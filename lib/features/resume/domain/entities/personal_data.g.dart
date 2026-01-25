// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalDataImpl _$$PersonalDataImplFromJson(Map<String, dynamic> json) =>
    _$PersonalDataImpl(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      portfolioUrl: json['portfolioUrl'] as String?,
      photoPath: json['photoPath'] as String?,
      oldResumePath: json['oldResumePath'] as String?,
      professionalObjective: json['professionalObjective'] as String? ?? '',
    );

Map<String, dynamic> _$$PersonalDataImplToJson(_$PersonalDataImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'linkedinUrl': instance.linkedinUrl,
      'portfolioUrl': instance.portfolioUrl,
      'photoPath': instance.photoPath,
      'oldResumePath': instance.oldResumePath,
      'professionalObjective': instance.professionalObjective,
    };
