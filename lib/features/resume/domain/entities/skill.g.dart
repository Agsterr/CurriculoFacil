// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      proficiency: (json['proficiency'] as num?)?.toDouble() ?? 0.5,
      isConfirmed: json['isConfirmed'] as bool? ?? true,
    );

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'proficiency': instance.proficiency,
      'isConfirmed': instance.isConfirmed,
    };
