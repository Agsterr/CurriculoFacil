// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResumeImpl _$$ResumeImplFromJson(Map<String, dynamic> json) => _$ResumeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      personalData:
          PersonalData.fromJson(json['personalData'] as Map<String, dynamic>),
      professionalObjective: json['professionalObjective'] as String,
      experiences: (json['experiences'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      style: json['style'] == null
          ? const ResumeStyle()
          : ResumeStyle.fromJson(json['style'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ResumeImplToJson(_$ResumeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'personalData': instance.personalData,
      'professionalObjective': instance.professionalObjective,
      'experiences': instance.experiences,
      'education': instance.education,
      'skills': instance.skills,
      'languages': instance.languages,
      'style': instance.style,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
