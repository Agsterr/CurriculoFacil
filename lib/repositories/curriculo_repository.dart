import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';
import '../models/curriculo_model.dart';

class CurriculoRepository {
  final AppDatabase _appDatabase = AppDatabase.instance;

  Future<void> saveResume(Resume resume) async {
    final db = await _appDatabase.database;

    await db.transaction((txn) async {
      // 1. Upsert Resume
      await txn.insert(
        'resumes',
        {
          'id': resume.id,
          'title': resume.title,
          'professional_objective': resume.professionalObjective,
          'personal_data': jsonEncode(resume.personalData.toJson()),
          'style': jsonEncode(resume.style.toJson()),
          'created_at': resume.createdAt.toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // 2. Educations
      await txn.delete('educations', where: 'resume_id = ?', whereArgs: [resume.id]);
      for (final edu in resume.education) {
        await txn.insert('educations', {
          'id': edu.id,
          'resume_id': resume.id,
          'institution': edu.institution,
          'degree': edu.degree,
          'field_of_study': edu.fieldOfStudy,
          'start_date': edu.startDate.toIso8601String(),
          'end_date': edu.endDate?.toIso8601String(),
          'is_current': edu.isCurrent ? 1 : 0,
        });
      }

      // 3. Experiences
      await txn.delete('experiences', where: 'resume_id = ?', whereArgs: [resume.id]);
      for (final exp in resume.experiences) {
        await txn.insert('experiences', {
          'id': exp.id,
          'resume_id': resume.id,
          'company': exp.company,
          'role': exp.role,
          'description': exp.description,
          'start_date': exp.startDate.toIso8601String(),
          'end_date': exp.endDate?.toIso8601String(),
          'is_current': exp.isCurrent ? 1 : 0,
        });
      }

      // 4. Skills
      await txn.delete('skills', where: 'resume_id = ?', whereArgs: [resume.id]);
      for (final skill in resume.skills) {
        await txn.insert('skills', {
          'id': skill.id,
          'resume_id': resume.id,
          'name': skill.name,
          'proficiency': skill.proficiency,
        });
      }

      // 5. Languages
      await txn.delete('languages', where: 'resume_id = ?', whereArgs: [resume.id]);
      for (final lang in resume.languages) {
        await txn.insert('languages', {
          'id': lang.id,
          'resume_id': resume.id,
          'name': lang.name,
          'proficiency': lang.proficiency.name,
        });
      }
    });
  }

  Future<List<Resume>> getAllResumes() async {
    final db = await _appDatabase.database;
    final resumeMaps = await db.query('resumes', orderBy: 'updated_at DESC');

    final resumes = <Resume>[];
    for (final map in resumeMaps) {
      resumes.add(await _buildResumeFromMap(db, map));
    }
    return resumes;
  }

  Future<Resume?> getResume(String id) async {
    final db = await _appDatabase.database;
    final maps = await db.query(
      'resumes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _buildResumeFromMap(db, maps.first);
    }
    return null;
  }

  Future<void> deleteResume(String id) async {
    final db = await _appDatabase.database;
    await db.delete('resumes', where: 'id = ?', whereArgs: [id]);
  }

  Future<Resume> _buildResumeFromMap(Database db, Map<String, dynamic> map) async {
    final resumeId = map['id'] as String;

    // Fetch Children
    final eduMaps = await db.query('educations', where: 'resume_id = ?', whereArgs: [resumeId]);
    final expMaps = await db.query('experiences', where: 'resume_id = ?', whereArgs: [resumeId]);
    final skillMaps = await db.query('skills', where: 'resume_id = ?', whereArgs: [resumeId]);
    final langMaps = await db.query('languages', where: 'resume_id = ?', whereArgs: [resumeId]);

    // Convert Lists
    final education = eduMaps.map((e) => Education(
          id: e['id'] as String,
          institution: e['institution'] as String,
          degree: e['degree'] as String,
          fieldOfStudy: e['field_of_study'] as String?,
          startDate: DateTime.parse(e['start_date'] as String),
          endDate: e['end_date'] != null ? DateTime.parse(e['end_date'] as String) : null,
          isCurrent: (e['is_current'] as int) == 1,
        )).toList();

    final experiences = expMaps.map((e) => Experience(
          id: e['id'] as String,
          company: e['company'] as String,
          role: e['role'] as String,
          description: e['description'] as String,
          startDate: DateTime.parse(e['start_date'] as String),
          endDate: e['end_date'] != null ? DateTime.parse(e['end_date'] as String) : null,
          isCurrent: (e['is_current'] as int) == 1,
        )).toList();

    final skills = skillMaps.map((e) => Skill(
          id: e['id'] as String,
          name: e['name'] as String,
          proficiency: e['proficiency'] as double,
        )).toList();

    final languages = langMaps.map((e) => Language(
          id: e['id'] as String,
          name: e['name'] as String,
          proficiency: LanguageProficiency.values.firstWhere((p) => p.name == e['proficiency']),
        )).toList();

    final personalDataMap = jsonDecode(map['personal_data'] as String);
    final styleMap = jsonDecode(map['style'] as String);

    return Resume(
      id: resumeId,
      title: map['title'] as String,
      professionalObjective: map['professional_objective'] as String,
      personalData: PersonalData.fromJson(personalDataMap),
      style: ResumeStyle.fromJson(styleMap),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      education: education,
      experiences: experiences,
      skills: skills,
      languages: languages,
    );
  }
}
