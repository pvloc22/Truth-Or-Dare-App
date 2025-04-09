import 'package:sqflite/sqflite.dart';
import 'package:truth_or_dare/models/Topic_model.dart';
import 'package:truth_or_dare/remote/handle_json_file.dart';
import 'package:truth_or_dare/remote/handle_sqlite.dart';


class HomeRepository {
  final HandleSqlite _handleSqlite = HandleSqlite();

  Future<List<Topic>> fetchAllTopics() async {
    Database db = await _handleSqlite.connectToDatabase();
    return _handleSqlite.getAllTopics(db);
  }
  Future<void> insertTopic(Topic topic) async {
    Database db = await _handleSqlite.connectToDatabase();
    await _handleSqlite.insertTopic(db, topic);
  }
}