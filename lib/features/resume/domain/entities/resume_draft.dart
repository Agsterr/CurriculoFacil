import '../../domain/entities/personal_data.dart';
import '../../domain/entities/education.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/skill.dart';

class ResumeDraft {
  final PersonalData personalData;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Skill> skills;

  const ResumeDraft({
    this.personalData = const PersonalData(
      fullName: '',
      email: '',
      phone: '',
    ),
    this.experiences = const [],
    this.education = const [],
    this.skills = const [],
  });
}
