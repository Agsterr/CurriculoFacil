// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'curriculo_model.dart';

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

PersonalData _$PersonalDataFromJson(Map<String, dynamic> json) {
  return _PersonalData.fromJson(json);
}

/// @nodoc
mixin _$PersonalData {
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get address =>
      throw _privateConstructorUsedError; // Deprecated: use structured fields below
  String? get street => throw _privateConstructorUsedError;
  String? get number => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get portfolioUrl => throw _privateConstructorUsedError;
  String? get photoPath => throw _privateConstructorUsedError;
  String? get oldResumePath => throw _privateConstructorUsedError;
  String get professionalObjective => throw _privateConstructorUsedError;

  /// Serializes this PersonalData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalDataCopyWith<PersonalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalDataCopyWith<$Res> {
  factory $PersonalDataCopyWith(
          PersonalData value, $Res Function(PersonalData) then) =
      _$PersonalDataCopyWithImpl<$Res, PersonalData>;
  @useResult
  $Res call(
      {String fullName,
      String email,
      String phone,
      String? address,
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
      String professionalObjective});
}

/// @nodoc
class _$PersonalDataCopyWithImpl<$Res, $Val extends PersonalData>
    implements $PersonalDataCopyWith<$Res> {
  _$PersonalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? address = freezed,
    Object? street = freezed,
    Object? number = freezed,
    Object? neighborhood = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
    Object? linkedinUrl = freezed,
    Object? portfolioUrl = freezed,
    Object? photoPath = freezed,
    Object? oldResumePath = freezed,
    Object? professionalObjective = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedinUrl: freezed == linkedinUrl
          ? _value.linkedinUrl
          : linkedinUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      portfolioUrl: freezed == portfolioUrl
          ? _value.portfolioUrl
          : portfolioUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoPath: freezed == photoPath
          ? _value.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      oldResumePath: freezed == oldResumePath
          ? _value.oldResumePath
          : oldResumePath // ignore: cast_nullable_to_non_nullable
              as String?,
      professionalObjective: null == professionalObjective
          ? _value.professionalObjective
          : professionalObjective // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalDataImplCopyWith<$Res>
    implements $PersonalDataCopyWith<$Res> {
  factory _$$PersonalDataImplCopyWith(
          _$PersonalDataImpl value, $Res Function(_$PersonalDataImpl) then) =
      __$$PersonalDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String email,
      String phone,
      String? address,
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
      String professionalObjective});
}

/// @nodoc
class __$$PersonalDataImplCopyWithImpl<$Res>
    extends _$PersonalDataCopyWithImpl<$Res, _$PersonalDataImpl>
    implements _$$PersonalDataImplCopyWith<$Res> {
  __$$PersonalDataImplCopyWithImpl(
      _$PersonalDataImpl _value, $Res Function(_$PersonalDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? address = freezed,
    Object? street = freezed,
    Object? number = freezed,
    Object? neighborhood = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
    Object? linkedinUrl = freezed,
    Object? portfolioUrl = freezed,
    Object? photoPath = freezed,
    Object? oldResumePath = freezed,
    Object? professionalObjective = null,
  }) {
    return _then(_$PersonalDataImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedinUrl: freezed == linkedinUrl
          ? _value.linkedinUrl
          : linkedinUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      portfolioUrl: freezed == portfolioUrl
          ? _value.portfolioUrl
          : portfolioUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoPath: freezed == photoPath
          ? _value.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      oldResumePath: freezed == oldResumePath
          ? _value.oldResumePath
          : oldResumePath // ignore: cast_nullable_to_non_nullable
              as String?,
      professionalObjective: null == professionalObjective
          ? _value.professionalObjective
          : professionalObjective // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalDataImpl implements _PersonalData {
  const _$PersonalDataImpl(
      {required this.fullName,
      required this.email,
      required this.phone,
      this.address,
      this.street,
      this.number,
      this.neighborhood,
      this.city,
      this.state,
      this.zipCode,
      this.linkedinUrl,
      this.portfolioUrl,
      this.photoPath,
      this.oldResumePath,
      this.professionalObjective = ''});

  factory _$PersonalDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalDataImplFromJson(json);

  @override
  final String fullName;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String? address;
// Deprecated: use structured fields below
  @override
  final String? street;
  @override
  final String? number;
  @override
  final String? neighborhood;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? zipCode;
  @override
  final String? linkedinUrl;
  @override
  final String? portfolioUrl;
  @override
  final String? photoPath;
  @override
  final String? oldResumePath;
  @override
  @JsonKey()
  final String professionalObjective;

  @override
  String toString() {
    return 'PersonalData(fullName: $fullName, email: $email, phone: $phone, address: $address, street: $street, number: $number, neighborhood: $neighborhood, city: $city, state: $state, zipCode: $zipCode, linkedinUrl: $linkedinUrl, portfolioUrl: $portfolioUrl, photoPath: $photoPath, oldResumePath: $oldResumePath, professionalObjective: $professionalObjective)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalDataImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.portfolioUrl, portfolioUrl) ||
                other.portfolioUrl == portfolioUrl) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            (identical(other.oldResumePath, oldResumePath) ||
                other.oldResumePath == oldResumePath) &&
            (identical(other.professionalObjective, professionalObjective) ||
                other.professionalObjective == professionalObjective));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fullName,
      email,
      phone,
      address,
      street,
      number,
      neighborhood,
      city,
      state,
      zipCode,
      linkedinUrl,
      portfolioUrl,
      photoPath,
      oldResumePath,
      professionalObjective);

  /// Create a copy of PersonalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalDataImplCopyWith<_$PersonalDataImpl> get copyWith =>
      __$$PersonalDataImplCopyWithImpl<_$PersonalDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalDataImplToJson(
      this,
    );
  }
}

abstract class _PersonalData implements PersonalData {
  const factory _PersonalData(
      {required final String fullName,
      required final String email,
      required final String phone,
      final String? address,
      final String? street,
      final String? number,
      final String? neighborhood,
      final String? city,
      final String? state,
      final String? zipCode,
      final String? linkedinUrl,
      final String? portfolioUrl,
      final String? photoPath,
      final String? oldResumePath,
      final String professionalObjective}) = _$PersonalDataImpl;

  factory _PersonalData.fromJson(Map<String, dynamic> json) =
      _$PersonalDataImpl.fromJson;

  @override
  String get fullName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String? get address; // Deprecated: use structured fields below
  @override
  String? get street;
  @override
  String? get number;
  @override
  String? get neighborhood;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get zipCode;
  @override
  String? get linkedinUrl;
  @override
  String? get portfolioUrl;
  @override
  String? get photoPath;
  @override
  String? get oldResumePath;
  @override
  String get professionalObjective;

  /// Create a copy of PersonalData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalDataImplCopyWith<_$PersonalDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Education _$EducationFromJson(Map<String, dynamic> json) {
  return _Education.fromJson(json);
}

/// @nodoc
mixin _$Education {
  String get id => throw _privateConstructorUsedError;
  String get institution => throw _privateConstructorUsedError;
  String get degree => throw _privateConstructorUsedError;
  String? get fieldOfStudy => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  bool get isConfirmed => throw _privateConstructorUsedError;

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EducationCopyWith<Education> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationCopyWith<$Res> {
  factory $EducationCopyWith(Education value, $Res Function(Education) then) =
      _$EducationCopyWithImpl<$Res, Education>;
  @useResult
  $Res call(
      {String id,
      String institution,
      String degree,
      String? fieldOfStudy,
      DateTime startDate,
      DateTime? endDate,
      bool isCurrent,
      bool isConfirmed});
}

/// @nodoc
class _$EducationCopyWithImpl<$Res, $Val extends Education>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institution = null,
    Object? degree = null,
    Object? fieldOfStudy = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? isConfirmed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      institution: null == institution
          ? _value.institution
          : institution // ignore: cast_nullable_to_non_nullable
              as String,
      degree: null == degree
          ? _value.degree
          : degree // ignore: cast_nullable_to_non_nullable
              as String,
      fieldOfStudy: freezed == fieldOfStudy
          ? _value.fieldOfStudy
          : fieldOfStudy // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EducationImplCopyWith<$Res>
    implements $EducationCopyWith<$Res> {
  factory _$$EducationImplCopyWith(
          _$EducationImpl value, $Res Function(_$EducationImpl) then) =
      __$$EducationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String institution,
      String degree,
      String? fieldOfStudy,
      DateTime startDate,
      DateTime? endDate,
      bool isCurrent,
      bool isConfirmed});
}

/// @nodoc
class __$$EducationImplCopyWithImpl<$Res>
    extends _$EducationCopyWithImpl<$Res, _$EducationImpl>
    implements _$$EducationImplCopyWith<$Res> {
  __$$EducationImplCopyWithImpl(
      _$EducationImpl _value, $Res Function(_$EducationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institution = null,
    Object? degree = null,
    Object? fieldOfStudy = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? isConfirmed = null,
  }) {
    return _then(_$EducationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      institution: null == institution
          ? _value.institution
          : institution // ignore: cast_nullable_to_non_nullable
              as String,
      degree: null == degree
          ? _value.degree
          : degree // ignore: cast_nullable_to_non_nullable
              as String,
      fieldOfStudy: freezed == fieldOfStudy
          ? _value.fieldOfStudy
          : fieldOfStudy // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EducationImpl implements _Education {
  const _$EducationImpl(
      {required this.id,
      required this.institution,
      required this.degree,
      this.fieldOfStudy,
      required this.startDate,
      this.endDate,
      this.isCurrent = false,
      this.isConfirmed = true});

  factory _$EducationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationImplFromJson(json);

  @override
  final String id;
  @override
  final String institution;
  @override
  final String degree;
  @override
  final String? fieldOfStudy;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isCurrent;
  @override
  @JsonKey()
  final bool isConfirmed;

  @override
  String toString() {
    return 'Education(id: $id, institution: $institution, degree: $degree, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.institution, institution) ||
                other.institution == institution) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.fieldOfStudy, fieldOfStudy) ||
                other.fieldOfStudy == fieldOfStudy) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, institution, degree,
      fieldOfStudy, startDate, endDate, isCurrent, isConfirmed);

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      __$$EducationImplCopyWithImpl<_$EducationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationImplToJson(
      this,
    );
  }
}

abstract class _Education implements Education {
  const factory _Education(
      {required final String id,
      required final String institution,
      required final String degree,
      final String? fieldOfStudy,
      required final DateTime startDate,
      final DateTime? endDate,
      final bool isCurrent,
      final bool isConfirmed}) = _$EducationImpl;

  factory _Education.fromJson(Map<String, dynamic> json) =
      _$EducationImpl.fromJson;

  @override
  String get id;
  @override
  String get institution;
  @override
  String get degree;
  @override
  String? get fieldOfStudy;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCurrent;
  @override
  bool get isConfirmed;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Experience _$ExperienceFromJson(Map<String, dynamic> json) {
  return _Experience.fromJson(json);
}

/// @nodoc
mixin _$Experience {
  String get id => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isConfirmed => throw _privateConstructorUsedError;

  /// Serializes this Experience to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceCopyWith<Experience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceCopyWith<$Res> {
  factory $ExperienceCopyWith(
          Experience value, $Res Function(Experience) then) =
      _$ExperienceCopyWithImpl<$Res, Experience>;
  @useResult
  $Res call(
      {String id,
      String company,
      String role,
      DateTime startDate,
      DateTime? endDate,
      bool isCurrent,
      String description,
      bool isConfirmed});
}

/// @nodoc
class _$ExperienceCopyWithImpl<$Res, $Val extends Experience>
    implements $ExperienceCopyWith<$Res> {
  _$ExperienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? role = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? description = null,
    Object? isConfirmed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExperienceImplCopyWith<$Res>
    implements $ExperienceCopyWith<$Res> {
  factory _$$ExperienceImplCopyWith(
          _$ExperienceImpl value, $Res Function(_$ExperienceImpl) then) =
      __$$ExperienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String company,
      String role,
      DateTime startDate,
      DateTime? endDate,
      bool isCurrent,
      String description,
      bool isConfirmed});
}

/// @nodoc
class __$$ExperienceImplCopyWithImpl<$Res>
    extends _$ExperienceCopyWithImpl<$Res, _$ExperienceImpl>
    implements _$$ExperienceImplCopyWith<$Res> {
  __$$ExperienceImplCopyWithImpl(
      _$ExperienceImpl _value, $Res Function(_$ExperienceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? role = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? description = null,
    Object? isConfirmed = null,
  }) {
    return _then(_$ExperienceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceImpl implements _Experience {
  const _$ExperienceImpl(
      {required this.id,
      required this.company,
      required this.role,
      required this.startDate,
      this.endDate,
      this.isCurrent = false,
      required this.description,
      this.isConfirmed = true});

  factory _$ExperienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceImplFromJson(json);

  @override
  final String id;
  @override
  final String company;
  @override
  final String role;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isCurrent;
  @override
  final String description;
  @override
  @JsonKey()
  final bool isConfirmed;

  @override
  String toString() {
    return 'Experience(id: $id, company: $company, role: $role, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, company, role, startDate,
      endDate, isCurrent, description, isConfirmed);

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceImplCopyWith<_$ExperienceImpl> get copyWith =>
      __$$ExperienceImplCopyWithImpl<_$ExperienceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceImplToJson(
      this,
    );
  }
}

abstract class _Experience implements Experience {
  const factory _Experience(
      {required final String id,
      required final String company,
      required final String role,
      required final DateTime startDate,
      final DateTime? endDate,
      final bool isCurrent,
      required final String description,
      final bool isConfirmed}) = _$ExperienceImpl;

  factory _Experience.fromJson(Map<String, dynamic> json) =
      _$ExperienceImpl.fromJson;

  @override
  String get id;
  @override
  String get company;
  @override
  String get role;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCurrent;
  @override
  String get description;
  @override
  bool get isConfirmed;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceImplCopyWith<_$ExperienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get proficiency => throw _privateConstructorUsedError;
  bool get isConfirmed => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({String id, String name, double proficiency, bool isConfirmed});
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? proficiency = null,
    Object? isConfirmed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      proficiency: null == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as double,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
          _$SkillImpl value, $Res Function(_$SkillImpl) then) =
      __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double proficiency, bool isConfirmed});
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
      _$SkillImpl _value, $Res Function(_$SkillImpl) _then)
      : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? proficiency = null,
    Object? isConfirmed = null,
  }) {
    return _then(_$SkillImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      proficiency: null == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as double,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl(
      {required this.id,
      required this.name,
      this.proficiency = 0.5,
      this.isConfirmed = true});

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final double proficiency;
  @override
  @JsonKey()
  final bool isConfirmed;

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, proficiency: $proficiency, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, proficiency, isConfirmed);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(
      this,
    );
  }
}

abstract class _Skill implements Skill {
  const factory _Skill(
      {required final String id,
      required final String name,
      final double proficiency,
      final bool isConfirmed}) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get proficiency;
  @override
  bool get isConfirmed;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return _Language.fromJson(json);
}

/// @nodoc
mixin _$Language {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  LanguageProficiency get proficiency => throw _privateConstructorUsedError;
  bool get isConfirmed => throw _privateConstructorUsedError;

  /// Serializes this Language to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageCopyWith<Language> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageCopyWith<$Res> {
  factory $LanguageCopyWith(Language value, $Res Function(Language) then) =
      _$LanguageCopyWithImpl<$Res, Language>;
  @useResult
  $Res call(
      {String id,
      String name,
      LanguageProficiency proficiency,
      bool isConfirmed});
}

/// @nodoc
class _$LanguageCopyWithImpl<$Res, $Val extends Language>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? proficiency = null,
    Object? isConfirmed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      proficiency: null == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as LanguageProficiency,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageImplCopyWith<$Res>
    implements $LanguageCopyWith<$Res> {
  factory _$$LanguageImplCopyWith(
          _$LanguageImpl value, $Res Function(_$LanguageImpl) then) =
      __$$LanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      LanguageProficiency proficiency,
      bool isConfirmed});
}

/// @nodoc
class __$$LanguageImplCopyWithImpl<$Res>
    extends _$LanguageCopyWithImpl<$Res, _$LanguageImpl>
    implements _$$LanguageImplCopyWith<$Res> {
  __$$LanguageImplCopyWithImpl(
      _$LanguageImpl _value, $Res Function(_$LanguageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? proficiency = null,
    Object? isConfirmed = null,
  }) {
    return _then(_$LanguageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      proficiency: null == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as LanguageProficiency,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageImpl implements _Language {
  const _$LanguageImpl(
      {required this.id,
      required this.name,
      required this.proficiency,
      this.isConfirmed = true});

  factory _$LanguageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final LanguageProficiency proficiency;
  @override
  @JsonKey()
  final bool isConfirmed;

  @override
  String toString() {
    return 'Language(id: $id, name: $name, proficiency: $proficiency, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, proficiency, isConfirmed);

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      __$$LanguageImplCopyWithImpl<_$LanguageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageImplToJson(
      this,
    );
  }
}

abstract class _Language implements Language {
  const factory _Language(
      {required final String id,
      required final String name,
      required final LanguageProficiency proficiency,
      final bool isConfirmed}) = _$LanguageImpl;

  factory _Language.fromJson(Map<String, dynamic> json) =
      _$LanguageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  LanguageProficiency get proficiency;
  @override
  bool get isConfirmed;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResumeStyle _$ResumeStyleFromJson(Map<String, dynamic> json) {
  return _ResumeStyle.fromJson(json);
}

/// @nodoc
mixin _$ResumeStyle {
  String get templateId => throw _privateConstructorUsedError;
  int get primaryColor => throw _privateConstructorUsedError;
  int get secondaryColor => throw _privateConstructorUsedError;
  String get frameType =>
      throw _privateConstructorUsedError; // none, line, box, side
  double get textScale => throw _privateConstructorUsedError;
  bool get showPhoto => throw _privateConstructorUsedError;
  String get fontFamily => throw _privateConstructorUsedError;

  /// Serializes this ResumeStyle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResumeStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResumeStyleCopyWith<ResumeStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResumeStyleCopyWith<$Res> {
  factory $ResumeStyleCopyWith(
          ResumeStyle value, $Res Function(ResumeStyle) then) =
      _$ResumeStyleCopyWithImpl<$Res, ResumeStyle>;
  @useResult
  $Res call(
      {String templateId,
      int primaryColor,
      int secondaryColor,
      String frameType,
      double textScale,
      bool showPhoto,
      String fontFamily});
}

/// @nodoc
class _$ResumeStyleCopyWithImpl<$Res, $Val extends ResumeStyle>
    implements $ResumeStyleCopyWith<$Res> {
  _$ResumeStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResumeStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? frameType = null,
    Object? textScale = null,
    Object? showPhoto = null,
    Object? fontFamily = null,
  }) {
    return _then(_value.copyWith(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryColor: null == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      frameType: null == frameType
          ? _value.frameType
          : frameType // ignore: cast_nullable_to_non_nullable
              as String,
      textScale: null == textScale
          ? _value.textScale
          : textScale // ignore: cast_nullable_to_non_nullable
              as double,
      showPhoto: null == showPhoto
          ? _value.showPhoto
          : showPhoto // ignore: cast_nullable_to_non_nullable
              as bool,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResumeStyleImplCopyWith<$Res>
    implements $ResumeStyleCopyWith<$Res> {
  factory _$$ResumeStyleImplCopyWith(
          _$ResumeStyleImpl value, $Res Function(_$ResumeStyleImpl) then) =
      __$$ResumeStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String templateId,
      int primaryColor,
      int secondaryColor,
      String frameType,
      double textScale,
      bool showPhoto,
      String fontFamily});
}

/// @nodoc
class __$$ResumeStyleImplCopyWithImpl<$Res>
    extends _$ResumeStyleCopyWithImpl<$Res, _$ResumeStyleImpl>
    implements _$$ResumeStyleImplCopyWith<$Res> {
  __$$ResumeStyleImplCopyWithImpl(
      _$ResumeStyleImpl _value, $Res Function(_$ResumeStyleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResumeStyle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? frameType = null,
    Object? textScale = null,
    Object? showPhoto = null,
    Object? fontFamily = null,
  }) {
    return _then(_$ResumeStyleImpl(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryColor: null == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      frameType: null == frameType
          ? _value.frameType
          : frameType // ignore: cast_nullable_to_non_nullable
              as String,
      textScale: null == textScale
          ? _value.textScale
          : textScale // ignore: cast_nullable_to_non_nullable
              as double,
      showPhoto: null == showPhoto
          ? _value.showPhoto
          : showPhoto // ignore: cast_nullable_to_non_nullable
              as bool,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResumeStyleImpl implements _ResumeStyle {
  const _$ResumeStyleImpl(
      {this.templateId = 'modern',
      this.primaryColor = 0xFF2196F3,
      this.secondaryColor = 0xFF757575,
      this.frameType = 'none',
      this.textScale = 1.0,
      this.showPhoto = true,
      this.fontFamily = 'Roboto'});

  factory _$ResumeStyleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResumeStyleImplFromJson(json);

  @override
  @JsonKey()
  final String templateId;
  @override
  @JsonKey()
  final int primaryColor;
  @override
  @JsonKey()
  final int secondaryColor;
  @override
  @JsonKey()
  final String frameType;
// none, line, box, side
  @override
  @JsonKey()
  final double textScale;
  @override
  @JsonKey()
  final bool showPhoto;
  @override
  @JsonKey()
  final String fontFamily;

  @override
  String toString() {
    return 'ResumeStyle(templateId: $templateId, primaryColor: $primaryColor, secondaryColor: $secondaryColor, frameType: $frameType, textScale: $textScale, showPhoto: $showPhoto, fontFamily: $fontFamily)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResumeStyleImpl &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.frameType, frameType) ||
                other.frameType == frameType) &&
            (identical(other.textScale, textScale) ||
                other.textScale == textScale) &&
            (identical(other.showPhoto, showPhoto) ||
                other.showPhoto == showPhoto) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, templateId, primaryColor,
      secondaryColor, frameType, textScale, showPhoto, fontFamily);

  /// Create a copy of ResumeStyle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResumeStyleImplCopyWith<_$ResumeStyleImpl> get copyWith =>
      __$$ResumeStyleImplCopyWithImpl<_$ResumeStyleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResumeStyleImplToJson(
      this,
    );
  }
}

abstract class _ResumeStyle implements ResumeStyle {
  const factory _ResumeStyle(
      {final String templateId,
      final int primaryColor,
      final int secondaryColor,
      final String frameType,
      final double textScale,
      final bool showPhoto,
      final String fontFamily}) = _$ResumeStyleImpl;

  factory _ResumeStyle.fromJson(Map<String, dynamic> json) =
      _$ResumeStyleImpl.fromJson;

  @override
  String get templateId;
  @override
  int get primaryColor;
  @override
  int get secondaryColor;
  @override
  String get frameType; // none, line, box, side
  @override
  double get textScale;
  @override
  bool get showPhoto;
  @override
  String get fontFamily;

  /// Create a copy of ResumeStyle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResumeStyleImplCopyWith<_$ResumeStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
