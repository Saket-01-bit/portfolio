import 'package:flutter/material.dart';

class PortfolioData {
  static const name = 'Saket Jain';
  static const title = 'Flutter Developer';
  static const subtitle = 'Mobile Application Engineer · DSA Practitioner';
  static const email = 'saketjainmm@gmail.com';
  static const phone = '+91-9041460252';
  static const location = 'Mohali, India';
  static const github = 'https://github.com/Saket-01-bit';
  static const linkedin = 'https://linkedin.com/in/saket-jain-cgc';
  static const String resume = "https://drive.google.com/file/d/1JaJDhYEV4kSRf8Emh2IAGKTX7QoveGhh/view?usp=drive_link";

  static const summary =
      'Results-driven Flutter Developer with hands-on experience shipping cross-platform mobile apps. '
      'Proven track record of improving app performance by 15–30% through clean architecture, '
      'efficient state management, and real-time data integration.';

  static const tagline = 'BUILDING FLUTTER APPS\nTHAT PERFORM.';

  static const List<SkillCategory> skills = [
    SkillCategory(
      label: 'MOBILE',
      items: ['Flutter', 'Dart', 'iOS & Android'],
    ),
    SkillCategory(
      label: 'STATE MGMT',
      items: ['Provider', 'BLoC', 'Riverpod', 'setState'],
    ),
    SkillCategory(
      label: 'BACKEND',
      items: ['Firebase Auth', 'Firestore', 'Realtime DB', 'REST APIs'],
    ),
    SkillCategory(
      label: 'LANGUAGES',
      items: ['Dart', 'Core Java', 'MySQL'],
    ),
    SkillCategory(
      label: 'TOOLS',
      items: ['Android Studio', 'VS Code', 'Git', 'GitHub', 'Postman'],
    ),
    SkillCategory(
      label: 'CS CORE',
      items: ['DSA', 'OOP', 'SOLID Principles', 'Clean Architecture'],
    ),
  ];

  static const List<Project> projects = [
    Project(
      name: 'HabitHero',
      role: 'Lead Developer',
      period: 'June 2025 – Present',
      tagline: 'Cross-Platform Habit Tracker',
      description:
          'Architected a Flutter app with clean architecture & modular design. '
          'Integrated Firebase Auth + Firestore for real-time sync. '
          'Built a reward-based streak engine with progress visualization.',
      bullets: [
        'Reduced future dev effort by ~25% via modular design',
        'Cut data retrieval latency by ~25% with Firestore optimizations',
        'Boosted user engagement & retention by ~20%',
        'Achieved 15–20% load time reduction, consistent 60fps',
      ],
      github: 'https://github.com/Saket-01-bit/HabitHero',
      tags: ['Flutter', 'Firebase', 'Provider', 'Clean Architecture'],
      accentColor: 0xFF5ED29C,
    ),
    Project(
      name: 'Romi',
      role: 'Developer',
      period: 'Aug 2025 – Present',
      tagline: 'AI-Powered Personal Assistant',
      description:
          'Built a real-time AI assistant with voice + text using Flutter async architecture. '
          'Integrated Groq API for NLP processing with ultra-low latency.',
      bullets: [
        'Cut response latency by 15–20% via async optimization',
        'Designed scalable feature-first modular architecture',
        'Voice + text dual-input interface',
      ],
      github: 'https://github.com/Saket-01-bit/Romi-Personalised-assistant',
      tags: ['Flutter', 'Groq API', 'NLP', 'Voice UI'],
      accentColor: 0xFF4FC3F7,
    ),
  ];

  static const List<Certificate> certifications = [
    Certificate(
      title: 'Fundamental Algorithms: Design & Analysis',
      issuer: 'NPTEL — IIT Kharagpur',
      year: '2024',
    ),
    Certificate(
      title: 'Introduction to Flutter',
      issuer: 'Simplilearn (SkillUp)',
      year: '2025',
    ),
  ];

  static const education = Education(
    degree: 'B.Tech — Information Technology',
    institution: 'Chandigarh Engineering College, CGC Landran',
    period: 'Aug 2023 – Present',
    cgpa: '7.82 / 10',
    coursework: ['Data Structures', 'OOP', 'DBMS', 'Software Engineering'],
  );

  static const leadership = Leadership(
    role: 'Vice President',
    organization: 'TechRoadies Club — CEC, CGC Landran',
    period: 'Aug 2025 – Present',
    bullets: [
      'Led technical workshops benefiting 800+ students',
      'Managed 10+ member core team across all club initiatives',
      'Increased workshop attendance by ~40% YoY',
    ],
  );
}

class SkillCategory {
  final String label;
  final List<String> items;
  const SkillCategory({required this.label, required this.items});
}

class Project {
  final String name;
  final String role;
  final String period;
  final String tagline;
  final String description;
  final List<String> bullets;
  final String github;
  final List<String> tags;
  final int accentColor;
  const Project({
    required this.name,
    required this.role,
    required this.period,
    required this.tagline,
    required this.description,
    required this.bullets,
    required this.github,
    required this.tags,
    required this.accentColor,
  });
}

class Certificate {
  final String title;
  final String issuer;
  final String year;
  const Certificate({required this.title, required this.issuer, required this.year});
}

class Education {
  final String degree;
  final String institution;
  final String period;
  final String cgpa;
  final List<String> coursework;
  const Education({
    required this.degree,
    required this.institution,
    required this.period,
    required this.cgpa,
    required this.coursework,
  });
}

class Leadership {
  final String role;
  final String organization;
  final String period;
  final List<String> bullets;
  const Leadership({
    required this.role,
    required this.organization,
    required this.period,
    required this.bullets,
  });
}

// ── Gallery ──────────────────────────────────────────────────────────────────

enum GalleryCategory { events, participations, certificates, moments }

class GalleryItem {
  final String assetPath;   // e.g. 'assets/gallery/events/techfest.jpg'
  final String title;
  final String subtitle;
  final GalleryCategory category;
  const GalleryItem({
    required this.assetPath,
    required this.title,
    required this.subtitle,
    required this.category,
  });
}

class GalleryData {
  // ─── HOW TO ADD YOUR PHOTOS ────────────────────────────────────────────────
  // 1. Create these folders inside your project:
  //      assets/gallery/events/
  //      assets/gallery/participations/
  //      assets/gallery/certificates/
  //      assets/gallery/moments/
  //
  // 2. Drop your photos in the matching folder.
  //
  // 3. Register them in pubspec.yaml:
  //      flutter:
  //        assets:
  //          - assets/gallery/events/
  //          - assets/gallery/participations/
  //          - assets/gallery/certificates/
  //          - assets/gallery/moments/
  //
  // 4. Add an entry below for each photo, e.g.:
  //      GalleryItem(
  //        assetPath: 'assets/gallery/events/techfest.jpg',
  //        title: 'TechFest 2024',
  //        subtitle: 'CGC Landran',
  //        category: GalleryCategory.events,
  //      ),
  // ──────────────────────────────────────────────────────────────────────────

  static const List<GalleryItem> items = [
    // EVENTS — replace placeholders with your real photos
    GalleryItem(
      assetPath: 'assets/gallery/events/placeholder_1.jpg',
      title: 'TechRoadies Workshop',
      subtitle: 'Hands-on coding session · CGC Landran',
      category: GalleryCategory.events,
    ),
    GalleryItem(
      assetPath: 'assets/gallery/events/placeholder_2.jpg',
      title: 'Tech Talk',
      subtitle: 'Industry-oriented session · 2025',
      category: GalleryCategory.events,
    ),
    GalleryItem(
      assetPath: 'assets/gallery/events/placeholder_3.jpg',
      title: 'Club Induction',
      subtitle: 'TechRoadies Club · Aug 2025',
      category: GalleryCategory.events,
    ),

    // PARTICIPATIONS
    GalleryItem(
      assetPath: 'assets/gallery/participations/placeholder_1.jpg',
      title: 'Hackathon',
      subtitle: 'Participant · 2024',
      category: GalleryCategory.participations,
    ),
    GalleryItem(
      assetPath: 'assets/gallery/participations/placeholder_2.jpg',
      title: 'Coding Contest',
      subtitle: 'DSA Round · 2024',
      category: GalleryCategory.participations,
    ),

    // CERTIFICATES
    GalleryItem(
      assetPath: 'assets/gallery/certificates/nptel.jpg',
      title: 'NPTEL — Fundamental Algorithms',
      subtitle: 'IIT Kharagpur · 2024',
      category: GalleryCategory.certificates,
    ),
    GalleryItem(
      assetPath: 'assets/gallery/certificates/flutter.jpg',
      title: 'Introduction to Flutter',
      subtitle: 'Simplilearn SkillUp · 2025',
      category: GalleryCategory.certificates,
    ),

    // MOMENTS
    GalleryItem(
      assetPath: 'assets/gallery/moments/placeholder_1.jpg',
      title: 'College Life',
      subtitle: 'CGC Landran · 2024',
      category: GalleryCategory.moments,
    ),
  ];

  static List<GalleryItem> byCategory(GalleryCategory cat) =>
      items.where((i) => i.category == cat).toList();

  static const categoryLabels = {
    GalleryCategory.events:         'EVENTS',
    GalleryCategory.participations: 'PARTICIPATIONS',
    GalleryCategory.certificates:   'CERTIFICATES',
    GalleryCategory.moments:        'MOMENTS',
  };

  static const categoryIcons = {
    GalleryCategory.events:         Icons.event_outlined,
    GalleryCategory.participations: Icons.emoji_events_outlined,
    GalleryCategory.certificates:   Icons.verified_outlined,
    GalleryCategory.moments:        Icons.photo_outlined,
  };
}
