import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String name,
    @Default(0.5) double proficiency, // 0.0 to 1.0
    @Default(true) bool isConfirmed,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) =>
      _$SkillFromJson(json);
}
