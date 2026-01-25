// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageImpl _$$LanguageImplFromJson(Map<String, dynamic> json) =>
    _$LanguageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      proficiency:
          $enumDecode(_$LanguageProficiencyEnumMap, json['proficiency']),
      isConfirmed: json['isConfirmed'] as bool? ?? true,
    );

Map<String, dynamic> _$$LanguageImplToJson(_$LanguageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'proficiency': _$LanguageProficiencyEnumMap[instance.proficiency]!,
      'isConfirmed': instance.isConfirmed,
    };

const _$LanguageProficiencyEnumMap = {
  LanguageProficiency.basic: 'basic',
  LanguageProficiency.intermediate: 'intermediate',
  LanguageProficiency.advanced: 'advanced',
  LanguageProficiency.fluent: 'fluent',
  LanguageProficiency.native: 'native',
};
