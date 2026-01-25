import 'package:freezed_annotation/freezed_annotation.dart';
import 'personal_data.dart';
import 'experience.dart';
import 'education.dart';
import 'skill.dart';
import 'language.dart';
import 'resume_style.dart';

part 'resume.freezed.dart';
part 'resume.g.dart';

@freezed
class Resume with _$Resume {
  const factory Resume({
    required String id,
    required String title,
    required PersonalData personalData,
    required String professionalObjective,
    @Default([]) List<Experience> experiences,
    @Default([]) List<Education> education,
    @Default([]) List<Skill> skills,
    @Default([]) List<Language> languages,
    @Default(ResumeStyle()) ResumeStyle style,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Resume;

  factory Resume.fromJson(Map<String, dynamic> json) =>
      _$ResumeFromJson(json);
}
