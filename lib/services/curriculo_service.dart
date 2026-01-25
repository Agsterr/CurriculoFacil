import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../core/providers/storage_provider.dart';
import '../models/curriculo_model.dart';
import '../repositories/curriculo_repository.dart';

part 'curriculo_service.g.dart';

// Repository Provider
@riverpod
CurriculoRepository curriculoRepository(CurriculoRepositoryRef ref) {
  return CurriculoRepository();
}

// Service: Gerencia a lista de currículos
@riverpod
class CurriculoListService extends _$CurriculoListService {
  @override
  Future<List<Resume>> build() async {
    final repository = ref.watch(curriculoRepositoryProvider);
    return repository.getAllResumes();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(curriculoRepositoryProvider);
      return repository.getAllResumes();
    });
  }

  Future<void> deleteResume(String id) async {
    final repository = ref.read(curriculoRepositoryProvider);
    await repository.deleteResume(id);
    await refresh();
  }
}

// Service: Gerencia o currículo atual em edição
@riverpod
class CurrentCurriculoService extends _$CurrentCurriculoService {
  Timer? _debounceTimer;
  static const _lastResumeIdKey = 'last_resume_id';

  @override
  Resume? build() {
    _restoreLastSession();
    return null;
  }

  Future<void> _restoreLastSession() async {
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      final lastId = prefs.getString(_lastResumeIdKey);
      if (lastId != null) {
        final repository = ref.read(curriculoRepositoryProvider);
        final resume = await repository.getResume(lastId);
        if (resume != null) {
          state = resume;
        }
      }
    } catch (e) {
      // Ignora erro de restauração em desenvolvimento ou se prefs não estiver pronto
    }
  }

  void setResume(Resume resume) {
    state = resume;
    _persistSession(resume.id);
  }

  Future<void> createNew({String? title}) async {
    final newResume = Resume(
      id: const Uuid().v4(),
      title: title ?? 'Novo Currículo',
      professionalObjective: '',
      personalData: const PersonalData(
        fullName: '',
        email: '',
        phone: '',
      ),
      style: const ResumeStyle(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    state = newResume;
    _persistSession(newResume.id);
    await _saveNow();
  }

  void _persistSession(String id) {
    try {
      ref.read(sharedPreferencesProvider).setString(_lastResumeIdKey, id);
    } catch (_) {}
  }

  // Método unificado para atualizar o currículo
  void updateResume(Resume newResume) {
    if (state == null) return;
    state = newResume;
    _scheduleSave();
  }

  // Helpers para atualizar partes específicas (facilita para a UI)
  void updatePersonalData(PersonalData data) {
    if (state == null) return;
    state = state!.copyWith(personalData: data);
    _scheduleSave();
  }

  void updateStyle(ResumeStyle style) {
    if (state == null) return;
    state = state!.copyWith(style: style);
    _scheduleSave();
  }

  // Education Helpers
  void addEducation(Education education) {
    if (state == null) return;
    state = state!.copyWith(education: [...state!.education, education]);
    _scheduleSave();
  }

  void updateEducation(Education education) {
    if (state == null) return;
    state = state!.copyWith(
      education: [
        for (final item in state!.education)
          if (item.id == education.id) education else item
      ],
    );
    _scheduleSave();
  }

  void removeEducation(String id) {
    if (state == null) return;
    state = state!.copyWith(
      education: state!.education.where((e) => e.id != id).toList(),
    );
    _scheduleSave();
  }

  // Experience Helpers
  void addExperience(Experience experience) {
    if (state == null) return;
    state = state!.copyWith(experiences: [...state!.experiences, experience]);
    _scheduleSave();
  }

  void updateExperience(Experience experience) {
    if (state == null) return;
    state = state!.copyWith(
      experiences: [
        for (final item in state!.experiences)
          if (item.id == experience.id) experience else item
      ],
    );
    _scheduleSave();
  }

  void removeExperience(String id) {
    if (state == null) return;
    state = state!.copyWith(
      experiences: state!.experiences.where((e) => e.id != id).toList(),
    );
    _scheduleSave();
  }

  // Skill Helpers
  void addSkill(Skill skill) {
    if (state == null) return;
    state = state!.copyWith(skills: [...state!.skills, skill]);
    _scheduleSave();
  }

  void updateSkill(Skill skill) {
    if (state == null) return;
    state = state!.copyWith(
      skills: [
        for (final item in state!.skills)
          if (item.id == skill.id) skill else item
      ],
    );
    _scheduleSave();
  }

  void removeSkill(String id) {
    if (state == null) return;
    state = state!.copyWith(
      skills: state!.skills.where((e) => e.id != id).toList(),
    );
    _scheduleSave();
  }

  // Language Helpers
  void addLanguage(Language language) {
    if (state == null) return;
    state = state!.copyWith(languages: [...state!.languages, language]);
    _scheduleSave();
  }

  void updateLanguage(Language language) {
    if (state == null) return;
    state = state!.copyWith(
      languages: [
        for (final item in state!.languages)
          if (item.id == language.id) language else item
      ],
    );
    _scheduleSave();
  }

  void removeLanguage(String id) {
    if (state == null) return;
    state = state!.copyWith(
      languages: state!.languages.where((e) => e.id != id).toList(),
    );
    _scheduleSave();
  }

  void _scheduleSave() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), _saveNow);
  }

  Future<void> _saveNow() async {
    if (state == null) return;

    // Atualiza timestamp
    state = state!.copyWith(updatedAt: DateTime.now());

    final repository = ref.read(curriculoRepositoryProvider);
    await repository.saveResume(state!);

    // Atualiza a lista
    ref.invalidate(curriculoListServiceProvider);
  }
}
