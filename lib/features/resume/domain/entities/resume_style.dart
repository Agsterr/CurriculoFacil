import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_style.freezed.dart';
part 'resume_style.g.dart';

@freezed
class ResumeStyle with _$ResumeStyle {
  const factory ResumeStyle({
    @Default('modern') String templateId,
    @Default(0xFF2196F3) int primaryColor, // Store as int for easy JSON serialization
    @Default(true) bool showPhoto,
    @Default('Roboto') String fontFamily,
  }) = _ResumeStyle;

  factory ResumeStyle.fromJson(Map<String, dynamic> json) =>
      _$ResumeStyleFromJson(json);
}
