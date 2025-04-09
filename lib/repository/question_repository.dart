import 'package:sqflite/sqflite.dart';
import 'package:truth_or_dare/models/Topic_model.dart';
import 'package:truth_or_dare/remote/handle_sqlite.dart';

import '../models/dare_model.dart';
import '../models/truth_model.dart';

class QuestionRepository {
  final HandleSqlite handleSqlite = HandleSqlite();

  Future<List<Truth>> fetchTruth(int idTopic) async {
    Database db = await handleSqlite.connectToDatabase();
    return await handleSqlite.getAllTruthWithTopicId(db, idTopic);
  }

  Future<List<Dare>> fetchDare(int idTopic) async {
    Database db = await handleSqlite.connectToDatabase();
    return await handleSqlite.getAllDareWithTopicId(db, idTopic);
  }

  Future<void> deleteDareOfTopic(int id, int idTopic) async {
    Database db = await handleSqlite.connectToDatabase();
    await handleSqlite.deleteDareOfTopic(db, idTopic, id);
  }

  Future<void> deleteTruthOfTopic(int id, int idTopic) async {
    Database db = await handleSqlite.connectToDatabase();
    await handleSqlite.deleteTruthOfTopic(db, idTopic, id);
  }
}
