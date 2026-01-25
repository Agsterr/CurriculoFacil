import 'package:freezed_annotation/freezed_annotation.dart';

part 'curriculo_model.freezed.dart';
part 'curriculo_model.g.dart';

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

  factory Resume.fromJson(Map<String, dynamic> json) => _$ResumeFromJson(json);
}

@freezed
class PersonalData with _$PersonalData {
  const factory PersonalData({
    required String fullName,
    required String email,
    required String phone,
    String? address, // Deprecated: use structured fields below
    String? street,
    String? number,
    String? neighborhood,
    String? city,
    String? state,
    String? zipCode,
    String? linkedinUrl,
    String? portfolioUrl,
    String? photoPath,
    String? oldResumePath,
    @Default('') String professionalObjective,
  }) = _PersonalData;

  factory PersonalData.fromJson(Map<String, dynamic> json) =>
      _$PersonalDataFromJson(json);
}

@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    required String institution,
    required String degree,
    String? fieldOfStudy,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    @Default(true) bool isConfirmed,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

@freezed
class Experience with _$Experience {
  const factory Experience({
    required String id,
    required String company,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    required String description,
    @Default(true) bool isConfirmed,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String name,
    @Default(0.5) double proficiency,
    @Default(true) bool isConfirmed,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

enum LanguageProficiency {
  basic,
  intermediate,
  advanced,
  fluent,
  native,
}

@freezed
class Language with _$Language {
  const factory Language({
    required String id,
    required String name,
    required LanguageProficiency proficiency,
    @Default(true) bool isConfirmed,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

@freezed
class ResumeStyle with _$ResumeStyle {
  const factory ResumeStyle({
    @Default('modern') String templateId,
    @Default(0xFF2196F3) int primaryColor,
    @Default(0xFF757575) int secondaryColor,
    @Default('none') String frameType, // none, line, box, side
    @Default(1.0) double textScale,
    @Default(true) bool showPhoto,
    @Default('Roboto') String fontFamily,
  }) = _ResumeStyle;

  factory ResumeStyle.fromJson(Map<String, dynamic> json) =>
      _$ResumeStyleFromJson(json);
}
