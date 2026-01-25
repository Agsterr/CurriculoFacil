import 'package:freezed_annotation/freezed_annotation.dart';

part 'education.freezed.dart';
part 'education.g.dart';

@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    required String institution,
    required String degree,
    String? fieldOfStudy,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    @Default(true) bool isConfirmed,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}
