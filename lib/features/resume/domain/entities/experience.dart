import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

@freezed
class Experience with _$Experience {
  const factory Experience({
    required String id,
    required String company,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    required String description,
    @Default(true) bool isConfirmed,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}
