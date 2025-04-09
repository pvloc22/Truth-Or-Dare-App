import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:truth_or_dare/remote/handle_json_file.dart';

import '../models/Topic_model.dart';
import '../models/dare_model.dart';
import '../models/truth_model.dart';

class HandleSqlite {
  static const String DATABASE_NAME = 'truth_or_dare_database.db';
  static const int DATABASE_VERSION = 1;

  Future<Database> connectToDatabase() async {
    try {
      // Ensure that the Flutter binding is initialized
      WidgetsFlutterBinding.ensureInitialized();

      // Get the database path
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, DATABASE_NAME);

      // Open the database (creates it if it doesn't exist)
      return openDatabase(
        path,
        version: DATABASE_VERSION,
        onCreate: _onCreate,
        onOpen: (Database db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      );
    } catch (e) {
      print('Error connecting to database: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      // Create tables
      await _createTables(db);

      // Load and insert initial data
      await _loadInitialData(db);
    } catch (e) {
      print('Error in onCreate: $e');
      rethrow;
    }
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE TOPICS(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE TRUTH (
        id INTEGER,
        name TEXT NOT NULL,
        id_topic INTEGER,
        is_delete INTEGER,
        PRIMARY KEY (id, id_topic),
        FOREIGN KEY (id_topic) REFERENCES TOPICS(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE DARE(
        id INTEGER,
        name TEXT NOT NULL,
        id_topic INTEGER,
        is_delete INTEGER,
        PRIMARY KEY (id, id_topic),  -- Cả id và id_topic cùng là khóa chính
        FOREIGN KEY (id_topic) REFERENCES TOPICS(id)
      )
    ''');

  }

  Future<void> _loadInitialData(Database db) async {
    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> topicsData = jsonData['Data'] as List<dynamic>;

      // Convert JSON data to Topic objects
      final List<Topic> topics = topicsData.map((json) => Topic.fromMap(json as Map<String, dynamic>)).toList();

      // Insert into database
      await insertFromJson(db, topics, topicsData);
    } catch (e) {
      print('Error loading initial data: $e');
      rethrow;
    }
  }

  Future<void> insertFromJson(Database db, List<Topic> topics, List<dynamic> topicsData) async {
    try {
      await db.transaction((txn) async {
        for (var i = 0; i < topics.length; i++) {
          final topic = topics[i];
          final topicData = topicsData[i] as Map<String, dynamic>;

          // Insert topic
          await txn.insert('TOPICS', topic.toMap());

          // Insert truths from JSON data
          final truths = topicData['truth'] as List<dynamic>? ?? [];
          for (var truth in truths) {
            print('${truth['is_delete'] ? 'Xoá' : ' Chưa xoá'}');
            await txn.insert('TRUTH', {
              'id': truth['id'] as int,
              'name': truth['name'] as String,
              'is_delete': truth['is_delete'] ? 1: 0 ,
              'id_topic': topic.id,
            });
          }

          // Insert dares from JSON data
          final dares = topicData['dare'] as List<dynamic>? ?? [];
          for (var dare in dares) {
            await txn.insert('DARE', {'id': dare['id'] as int, 'name': dare['name'] as String, 'is_delete': dare['is_delete'] ? 1: 0 , 'id_topic': topic.id});
          }
        }
      });
    } catch (e) {
      print('Error inserting data: $e');
      rethrow;
    }
  }

  Future<void> insertTruth(Database db, Truth truth) async {
    try {
      await db.insert('TRUTH', truth.toMap());
    } catch (e) {
      print('Error inserting truth: $e');
      rethrow;
    }
  }

  Future<void> insertDare(Database db, Dare dare) async {
    try {
      await db.insert('DARE', dare.toMap());
    } catch (e) {
      print('Error inserting dare: $e');
      rethrow;
    }
  }
  Future<void> insertTopic(Database db, Topic topic) async {
    try {
      await db.insert('TOPICS', topic.toMap());
    } catch (e) {
      print('Error inserting topic: $e');
      rethrow;  
    }
  }

  Future<List<Topic>> getAllTopics(Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query('TOPICS');
      return List.generate(maps.length, (i) => Topic.fromMap(maps[i]));
    } catch (e) {
      print('Error getting topics: $e');
      rethrow;
    }
  }
  Future<List<Truth>> getAllTruthWithTopicId(Database db, int topicId) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query('TRUTH', where: 'id_topic = ?', whereArgs: [topicId]);
      print(maps);
      return List.generate(maps.length, (i) => Truth.fromMap(maps[i]));
    } catch (e) {
      print('Error getting truths: $e');  
      rethrow;
    }
  }
  Future<List<Dare>> getAllDareWithTopicId(Database db, int topicId) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query('DARE', where: 'id_topic = ? AND is_delete = ?', whereArgs: [topicId, 0]);
      return List.generate(maps.length, (i) => Dare.fromMap(maps[i]));
    } catch (e) {
      print('Error getting dares: $e');
      rethrow;
    }
  }
  Future<void> deleteTopic(Database db, int topicId) async {
    try {
      await db.delete('TOPICS', where: 'id = ?', whereArgs: [topicId]);
    } catch (e) {
      print('Error deleting topic: $e');
      rethrow;
    }
  }

  Future<void> deleteTruthOfTopic(Database db, int topicId, int truthId) async {
    try{
      int count = await db.update('TRUTH', {'is_delete': 1}, where: 'id_topic = ? AND id = ?', whereArgs: [topicId, truthId]);
      if (count <= 0) {
        print('Truth not found');
      }
    } catch (e) {
      print('Error deleting truth of topic: $e');
      rethrow;
    }
  }
  Future<void> deleteDareOfTopic(Database db, int topicId, int dareId) async {
    try{
      await db.update('DARE', {'is_delete': 1}, where: 'id_topic = ? AND id = ?', whereArgs: [topicId, dareId]);
    } catch (e) {
      print('Error deleting dare of topic: $e');
      rethrow;
    }
  }
}
