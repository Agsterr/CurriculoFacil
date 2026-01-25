import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/resume/presentation/pages/personal_data_page.dart';
import '../../features/resume/presentation/pages/resume_preview_page.dart';
import '../../features/resume/presentation/pages/education_list_page.dart';
import '../../features/resume/presentation/pages/experience_list_page.dart';
import '../../features/resume/presentation/pages/skill_list_page.dart';
import '../../features/resume/presentation/pages/attachments_page.dart';
import '../../features/resume/presentation/pages/home_page.dart';
import '../../features/resume/presentation/pages/resume_list_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ResumeListPage(),
      ),
      GoRoute(
        path: '/edit',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/personal-data',
        builder: (context, state) => const PersonalDataPage(),
      ),
      GoRoute(
        path: '/experience',
        builder: (context, state) => const ExperienceListPage(),
      ),
      GoRoute(
        path: '/education',
        builder: (context, state) => const EducationListPage(),
      ),
      GoRoute(
        path: '/skills',
        builder: (context, state) => const SkillListPage(),
      ),
      GoRoute(
        path: '/attachments',
        builder: (context, state) => const AttachmentsPage(),
      ),
      GoRoute(
        path: '/preview',
        builder: (context, state) => const ResumePreviewPage(),
      ),
    ],
  );
}
