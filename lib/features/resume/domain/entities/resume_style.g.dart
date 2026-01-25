// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResumeStyleImpl _$$ResumeStyleImplFromJson(Map<String, dynamic> json) =>
    _$ResumeStyleImpl(
      templateId: json['templateId'] as String? ?? 'modern',
      primaryColor: (json['primaryColor'] as num?)?.toInt() ?? 0xFF2196F3,
      showPhoto: json['showPhoto'] as bool? ?? true,
      fontFamily: json['fontFamily'] as String? ?? 'Roboto',
    );

Map<String, dynamic> _$$ResumeStyleImplToJson(_$ResumeStyleImpl instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'primaryColor': instance.primaryColor,
      'showPhoto': instance.showPhoto,
      'fontFamily': instance.fontFamily,
    };
