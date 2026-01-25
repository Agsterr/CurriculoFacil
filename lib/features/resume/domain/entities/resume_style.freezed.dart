// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResumeStyle _$ResumeStyleFromJson(Map<String, dynamic> json) {
  return _ResumeStyle.fromJson(json);
}

/// @nodoc
mixin _$ResumeStyle {
  String get templateId => throw _privateConstructorUsedError;
  int get primaryColor =>
      throw _privateConstructorUsedError; // Store as int for easy JSON serialization
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
      {String templateId, int primaryColor, bool showPhoto, String fontFamily});
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
      {String templateId, int primaryColor, bool showPhoto, String fontFamily});
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
// Store as int for easy JSON serialization
  @override
  @JsonKey()
  final bool showPhoto;
  @override
  @JsonKey()
  final String fontFamily;

  @override
  String toString() {
    return 'ResumeStyle(templateId: $templateId, primaryColor: $primaryColor, showPhoto: $showPhoto, fontFamily: $fontFamily)';
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
            (identical(other.showPhoto, showPhoto) ||
                other.showPhoto == showPhoto) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, templateId, primaryColor, showPhoto, fontFamily);

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
      final bool showPhoto,
      final String fontFamily}) = _$ResumeStyleImpl;

  factory _ResumeStyle.fromJson(Map<String, dynamic> json) =
      _$ResumeStyleImpl.fromJson;

  @override
  String get templateId;
  @override
  int get primaryColor; // Store as int for easy JSON serialization
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
