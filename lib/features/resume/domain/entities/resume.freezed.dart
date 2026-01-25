// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Resume _$ResumeFromJson(Map<String, dynamic> json) {
  return _Resume.fromJson(json);
}

/// @nodoc
mixin _$Resume {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  PersonalData get personalData => throw _privateConstructorUsedError;
  String get professionalObjective => throw _privateConstructorUsedError;
  List<Experience> get experiences => throw _privateConstructorUsedError;
  List<Education> get education => throw _privateConstructorUsedError;
  List<Skill> get skills => throw _privateConstructorUsedError;
  List<Language> get languages => throw _privateConstructorUsedError;
  ResumeStyle get style => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Resume to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResumeCopyWith<Resume> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResumeCopyWith<$Res> {
  factory $ResumeCopyWith(Resume value, $Res Function(Resume) then) =
      _$ResumeCopyWithImpl<$Res, Resume>;
  @useResult
  $Res call(
      {String id,
      String title,
      PersonalData personalData,
      String professionalObjective,
      List<Experience> experiences,
      List<Education> education,
      List<Skill> skills,
      List<Language> languages,
      ResumeStyle style,
      DateTime createdAt,
      DateTime updatedAt});

  $PersonalDataCopyWith<$Res> get personalData;
  $ResumeStyleCopyWith<$Res> get style;
}

/// @nodoc
class _$ResumeCopyWithImpl<$Res, $Val extends Resume>
    implements $ResumeCopyWith<$Res> {
  _$ResumeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? personalData = null,
    Object? professionalObjective = null,
    Object? experiences = null,
    Object? education = null,
    Object? skills = null,
    Object? languages = null,
    Object? style = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      personalData: null == personalData
          ? _value.personalData
          : personalData // ignore: cast_nullable_to_non_nullable
              as PersonalData,
      professionalObjective: null == professionalObjective
          ? _value.professionalObjective
          : professionalObjective // ignore: cast_nullable_to_non_nullable
              as String,
      experiences: null == experiences
          ? _value.experiences
          : experiences // ignore: cast_nullable_to_non_nullable
              as List<Experience>,
      education: null == education
          ? _value.education
          : education // ignore: cast_nullable_to_non_nullable
              as List<Education>,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      languages: null == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<Language>,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as ResumeStyle,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonalDataCopyWith<$Res> get personalData {
    return $PersonalDataCopyWith<$Res>(_value.personalData, (value) {
      return _then(_value.copyWith(personalData: value) as $Val);
    });
  }

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResumeStyleCopyWith<$Res> get style {
    return $ResumeStyleCopyWith<$Res>(_value.style, (value) {
      return _then(_value.copyWith(style: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResumeImplCopyWith<$Res> implements $ResumeCopyWith<$Res> {
  factory _$$ResumeImplCopyWith(
          _$ResumeImpl value, $Res Function(_$ResumeImpl) then) =
      __$$ResumeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      PersonalData personalData,
      String professionalObjective,
      List<Experience> experiences,
      List<Education> education,
      List<Skill> skills,
      List<Language> languages,
      ResumeStyle style,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $PersonalDataCopyWith<$Res> get personalData;
  @override
  $ResumeStyleCopyWith<$Res> get style;
}

/// @nodoc
class __$$ResumeImplCopyWithImpl<$Res>
    extends _$ResumeCopyWithImpl<$Res, _$ResumeImpl>
    implements _$$ResumeImplCopyWith<$Res> {
  __$$ResumeImplCopyWithImpl(
      _$ResumeImpl _value, $Res Function(_$ResumeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? personalData = null,
    Object? professionalObjective = null,
    Object? experiences = null,
    Object? education = null,
    Object? skills = null,
    Object? languages = null,
    Object? style = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ResumeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      personalData: null == personalData
          ? _value.personalData
          : personalData // ignore: cast_nullable_to_non_nullable
              as PersonalData,
      professionalObjective: null == professionalObjective
          ? _value.professionalObjective
          : professionalObjective // ignore: cast_nullable_to_non_nullable
              as String,
      experiences: null == experiences
          ? _value._experiences
          : experiences // ignore: cast_nullable_to_non_nullable
              as List<Experience>,
      education: null == education
          ? _value._education
          : education // ignore: cast_nullable_to_non_nullable
              as List<Education>,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      languages: null == languages
          ? _value._languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<Language>,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as ResumeStyle,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResumeImpl implements _Resume {
  const _$ResumeImpl(
      {required this.id,
      required this.title,
      required this.personalData,
      required this.professionalObjective,
      final List<Experience> experiences = const [],
      final List<Education> education = const [],
      final List<Skill> skills = const [],
      final List<Language> languages = const [],
      this.style = const ResumeStyle(),
      required this.createdAt,
      required this.updatedAt})
      : _experiences = experiences,
        _education = education,
        _skills = skills,
        _languages = languages;

  factory _$ResumeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResumeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final PersonalData personalData;
  @override
  final String professionalObjective;
  final List<Experience> _experiences;
  @override
  @JsonKey()
  List<Experience> get experiences {
    if (_experiences is EqualUnmodifiableListView) return _experiences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_experiences);
  }

  final List<Education> _education;
  @override
  @JsonKey()
  List<Education> get education {
    if (_education is EqualUnmodifiableListView) return _education;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_education);
  }

  final List<Skill> _skills;
  @override
  @JsonKey()
  List<Skill> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<Language> _languages;
  @override
  @JsonKey()
  List<Language> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  @override
  @JsonKey()
  final ResumeStyle style;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Resume(id: $id, title: $title, personalData: $personalData, professionalObjective: $professionalObjective, experiences: $experiences, education: $education, skills: $skills, languages: $languages, style: $style, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResumeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.personalData, personalData) ||
                other.personalData == personalData) &&
            (identical(other.professionalObjective, professionalObjective) ||
                other.professionalObjective == professionalObjective) &&
            const DeepCollectionEquality()
                .equals(other._experiences, _experiences) &&
            const DeepCollectionEquality()
                .equals(other._education, _education) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._languages, _languages) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      personalData,
      professionalObjective,
      const DeepCollectionEquality().hash(_experiences),
      const DeepCollectionEquality().hash(_education),
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_languages),
      style,
      createdAt,
      updatedAt);

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResumeImplCopyWith<_$ResumeImpl> get copyWith =>
      __$$ResumeImplCopyWithImpl<_$ResumeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResumeImplToJson(
      this,
    );
  }
}

abstract class _Resume implements Resume {
  const factory _Resume(
      {required final String id,
      required final String title,
      required final PersonalData personalData,
      required final String professionalObjective,
      final List<Experience> experiences,
      final List<Education> education,
      final List<Skill> skills,
      final List<Language> languages,
      final ResumeStyle style,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ResumeImpl;

  factory _Resume.fromJson(Map<String, dynamic> json) = _$ResumeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  PersonalData get personalData;
  @override
  String get professionalObjective;
  @override
  List<Experience> get experiences;
  @override
  List<Education> get education;
  @override
  List<Skill> get skills;
  @override
  List<Language> get languages;
  @override
  ResumeStyle get style;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Resume
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResumeImplCopyWith<_$ResumeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
