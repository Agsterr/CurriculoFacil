import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/curriculo_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('curriculo_facil.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textNullableType = 'TEXT';
    const boolType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    // Tabela Resumes
    await db.execute('''
      CREATE TABLE resumes (
        id $idType,
        title $textType,
        professional_objective $textType,
        personal_data $textType, -- JSON
        style $textType, -- JSON
        created_at $textType,
        updated_at $textType
      )
    ''');

    // Tabela Educations
    await db.execute('''
      CREATE TABLE educations (
        id $idType,
        resume_id $textType,
        institution $textType,
        degree $textType,
        field_of_study $textNullableType,
        start_date $textType,
        end_date $textNullableType,
        is_current $boolType,
        FOREIGN KEY (resume_id) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    // Tabela Experiences
    await db.execute('''
      CREATE TABLE experiences (
        id $idType,
        resume_id $textType,
        company $textType,
        role $textType,
        description $textType,
        start_date $textType,
        end_date $textNullableType,
        is_current $boolType,
        FOREIGN KEY (resume_id) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    // Tabela Skills
    await db.execute('''
      CREATE TABLE skills (
        id $idType,
        resume_id $textType,
        name $textType,
        proficiency $realType,
        FOREIGN KEY (resume_id) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');

    // Tabela Languages
    await db.execute('''
      CREATE TABLE languages (
        id $idType,
        resume_id $textType,
        name $textType,
        proficiency $textType, -- Enum as String
        FOREIGN KEY (resume_id) REFERENCES resumes (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
