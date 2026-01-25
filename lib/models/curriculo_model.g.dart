// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculo_model.dart';

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

_$PersonalDataImpl _$$PersonalDataImplFromJson(Map<String, dynamic> json) =>
    _$PersonalDataImpl(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      street: json['street'] as String?,
      number: json['number'] as String?,
      neighborhood: json['neighborhood'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
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
      'street': instance.street,
      'number': instance.number,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'linkedinUrl': instance.linkedinUrl,
      'portfolioUrl': instance.portfolioUrl,
      'photoPath': instance.photoPath,
      'oldResumePath': instance.oldResumePath,
      'professionalObjective': instance.professionalObjective,
    };

_$EducationImpl _$$EducationImplFromJson(Map<String, dynamic> json) =>
    _$EducationImpl(
      id: json['id'] as String,
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool? ?? false,
      isConfirmed: json['isConfirmed'] as bool? ?? true,
    );

Map<String, dynamic> _$$EducationImplToJson(_$EducationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institution': instance.institution,
      'degree': instance.degree,
      'fieldOfStudy': instance.fieldOfStudy,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'isConfirmed': instance.isConfirmed,
    };

_$ExperienceImpl _$$ExperienceImplFromJson(Map<String, dynamic> json) =>
    _$ExperienceImpl(
      id: json['id'] as String,
      company: json['company'] as String,
      role: json['role'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool? ?? false,
      description: json['description'] as String,
      isConfirmed: json['isConfirmed'] as bool? ?? true,
    );

Map<String, dynamic> _$$ExperienceImplToJson(_$ExperienceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'role': instance.role,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'description': instance.description,
      'isConfirmed': instance.isConfirmed,
    };

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

_$ResumeStyleImpl _$$ResumeStyleImplFromJson(Map<String, dynamic> json) =>
    _$ResumeStyleImpl(
      templateId: json['templateId'] as String? ?? 'modern',
      primaryColor: (json['primaryColor'] as num?)?.toInt() ?? 0xFF2196F3,
      secondaryColor: (json['secondaryColor'] as num?)?.toInt() ?? 0xFF757575,
      frameType: json['frameType'] as String? ?? 'none',
      textScale: (json['textScale'] as num?)?.toDouble() ?? 1.0,
      showPhoto: json['showPhoto'] as bool? ?? true,
      fontFamily: json['fontFamily'] as String? ?? 'Roboto',
    );

Map<String, dynamic> _$$ResumeStyleImplToJson(_$ResumeStyleImpl instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'frameType': instance.frameType,
      'textScale': instance.textScale,
      'showPhoto': instance.showPhoto,
      'fontFamily': instance.fontFamily,
    };
