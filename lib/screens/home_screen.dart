import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_header.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  final _projectsKey = GlobalKey();
  final _skillsKey   = GlobalKey();
  final _aboutKey    = GlobalKey();
  final _contactKey  = GlobalKey();

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navActions = <String, VoidCallback>{
      'PROJECTS': () => _scrollToKey(_projectsKey),
      'SKILLS':   () => _scrollToKey(_skillsKey),
      'ABOUT':    () => _scrollToKey(_aboutKey),
      'RESUME':   () => _scrollToKey(_contactKey),
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Nav takes its natural height, content starts below it
            NavHeader(
              scrollController: _scrollController,
              navActions: navActions,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HeroSection(
                      onViewProjects: () => _scrollToKey(_projectsKey),
                      onContact:      () => _scrollToKey(_contactKey),
                    ),
                    ProjectsSection(key: _projectsKey),
                    SkillsSection(key: _skillsKey),
                    AboutSection(key: _aboutKey),
                    ContactSection(key: _contactKey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}