import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper
{
  static Database? _database;

  // Singleton // +
  static final DatabaseHelper singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return singleton;
  }

  DatabaseHelper._internal();
  // Singleton // -

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'finances.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  
  Future _onCreate(Database db, int version) async{
    
    await db.execute('''
    CREATE TABLE ACCOUNT
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,
      income INTEGER
    );
    ''');
    
  }

  Future addIncome(int value) async
  {
    Database db = await singleton.database;
    await db.rawInsert("INSERT INTO ACCOUNT(income) VALUES ($value)");
  }

  Future readIncome() async
  {
    Database db = await singleton.database;
    await db.rawQuery("SELECT * FROM ACCOUNT");
  }

  Future deleteIncome() async
  {
    Database db = await singleton.database;
    await db.rawInsert("DELETE FROM ACCOUNT");
  }

  Future deleteTables() async
  {
    Database db = await singleton.database;
    await db.rawDelete("DROP TABLE ACCOUNT");
  }

  Future createTables() async
  {
    Database db = await singleton.database;
    await db.execute('''
    CREATE TABLE ACCOUNT
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,
      income INTEGER
    );
    ''');
  }

}