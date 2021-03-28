import 'dart:io';

import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'serviceUsers.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE therapistUsers('
          'id INTEGER,'
          'eventId INTEGER,'
          'menuName TEXT,'
          'menuIcon TEXT,'
          'deepLinkName TEXT,'
          'displayStatus INTEGER,'
          'orderId INTEGER,'
          'DateTime TEXT'
          ')');
    });
  }

  // Insert therapist users on database
  createTherapistUsers(TherapistUsersModel therapistUsersModel) async {
    await deleteAllTherapistUsers();
    final db = await database;
    final res = await db.insert('therapistUsers', therapistUsersModel.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllTherapistUsers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM therapistUsers');

    return res;
  }

  Future<List<TherapistUsersModel>> getAllTherapistUsers() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM therapistUsers");

    List<TherapistUsersModel> list = res.isNotEmpty
        ? res.map((c) => TherapistUsersModel.fromJson(c)).toList()
        : [];

    return list;
  }
}
