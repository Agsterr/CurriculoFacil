import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_data.freezed.dart';
part 'personal_data.g.dart';

@freezed
class PersonalData with _$PersonalData {
  const factory PersonalData({
    required String fullName,
    required String email,
    required String phone,
    String? address,
    String? linkedinUrl,
    String? portfolioUrl,
    String? photoPath, // Local path to the image file
    String? oldResumePath, // Local path to the old resume file (PDF or Image)
    @Default('') String professionalObjective,
  }) = _PersonalData;

  factory PersonalData.fromJson(Map<String, dynamic> json) =>
      _$PersonalDataFromJson(json);
}
