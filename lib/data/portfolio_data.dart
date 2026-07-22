class PortfolioData {
  static const name = 'Saket Jain';
  static const title = 'Flutter Developer';
  static const subtitle = 'Mobile Application Engineer · DSA Practitioner';
  static const email = 'saketjainmm@gmail.com';
  static const phone = '+91-9041460252';
  static const location = 'Mohali, India';
  static const github = 'https://github.com/Saket-01-bit';
  static const linkedin = 'https://linkedin.com/in/saket-jain-cgc';
  static const String resume =
      "https://drive.google.com/file/d/1TJrhEXclyE09x_7aV_zX-aFfzKxbe1Cr/view?usp=sharing";

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
      items: ['Provider', 'BLoC', 'Riverpod', 'GetX'],
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
      items: ['Android Studio', 'VS Code', 'Git', 'GitHub'],
    ),
    SkillCategory(
      label: 'CS CORE',
      items: ['DSA', 'OOP', 'SOLID Principles', 'Clean Architecture'],
    ),
  ];

  static const List<Project> projects = [
    Project(
      name: 'HabitHero',
      role: 'Sole Developer',
      category: 'flutter',
      period: 'June 2025 – Present',
      tagline: 'Cross-Platform Habit Tracker',
      description:
          'Architected a Flutter app with clean architecture & modular design. '
          'Integrated Firebase Auth + Firestore for real-time sync. '
          'Built a reward-based streak engine with progress visualization.',
      bullets: [
        'Reduced future dev effort by ~25% via modular design',
        'Boosted user engagement & retention by ~20%',
        'Achieved 15–20% load time reduction, consistent 60fps',
      ],
      github: 'https://github.com/Saket-01-bit/HabitHero',
      tags: ['Flutter', 'Firebase', 'Provider', 'Clean Architecture'],
      accentColor: 0xFF5ED29C,
    ),
    Project(
      name: 'Romi',
      role: 'Sole Developer',
      category: 'flutter',
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
    Project(
      name: 'Flutter Portfolio',
      role: 'Sole Developer',
      category: 'flutter',
      period: 'May 2026 – Present',
      tagline: 'Personal Portfolio App',
      description:
          'Designed a Flutter portfolio app showcasing projects, skills, and certifications. '
          'Implemented responsive UI with Material Design 3 principles.',
      bullets: [
        'Showcased projects with dynamic data models',
        'Implemented responsive design for multiple screen sizes',
        'Used Material Design 3 for modern UI/UX',
      ],
      github: 'https://saketjain.vercel.app',
      tags: ['Flutter, Dart', 'Material Design 3', 'Responsive UI'],
      accentColor: 0xFF5ED29C,
    ),
    Project(
      name: 'WARDROBE_AI',
      role: 'Developer',
      category: 'flutter',
      period: 'June 2026-Present',
      tagline: 'AI-Powered Outfit Recommender',
      description:
          'WardrobeAI is a fully offline Flutter wardrobe app with AI-powered outfit suggestions, masonry grid, and a luxury dark/light UI built with Riverpod, Hive, and GoRouter.',
      bullets: [
        'Offline Flutter wardrobe app using Riverpod and Hive.,'
            'Rule-based AI outfit suggestions via color harmony theory.',
        'Luxury dark/light UI with masonry grid and outfit builder.'
      ],
      github: 'https://github.com/Saket-01-bit/wardrobe_ai',
      accentColor: 0xFF4FC3F7,
      tags: ['Flutter', 'Local Machine Model'],
    ),
    Project(
      name: 'Food Ordering System',
      role: 'Java Developer',
      category: 'java',
      //period: '2025',
      tagline: 'Console-Based Restaurant Ordering System',
      description:
          'Developed a console-based food ordering application in Java that enables menu browsing, food customization, shopping cart management, checkout, and order history while demonstrating object-oriented design principles and software design patterns.',
      bullets: [
        'Implemented the Prototype pattern for efficient menu item cloning and customization.',
        'Applied the Template Method pattern to enable reusable and extensible food item behavior.',
        'Built menu browsing, cart management, checkout, and order history workflows.',
        'Designed a modular object-oriented architecture for maintainable code.',
      ],
      github: 'https://github.com/Saket-01-bit/Food-Ordering-System',
      tags: [
        'Java',
        'OOP',
        'Prototype Pattern',
        'Template Method',
        'Design Patterns'
      ],
      accentColor: 0xFFF4A261,
    ),
    Project(
      name: 'Ride Sharing System',
      role: 'Java Developer',
      category: 'java',
      //period: '2025',
      tagline: 'Console-Based Ride Booking & Management System',
      description:
      'Developed a backend-style ride-sharing system in Java that simulates rider-driver matching, dynamic fare calculation, ride lifecycle management, and ratings using object-oriented design principles and the Strategy design pattern.',
      bullets: [
        'Implemented the Strategy pattern for dynamic normal and surge fare calculation.',
        'Designed a layered architecture with services, models, strategies, and custom exceptions.',
        'Built ride matching, ETA estimation, ride lifecycle, ratings, and ride history.',
        'Enforced ride state transitions with robust exception handling.',
      ],
      github: 'https://github.com/Saket-01-bit/ride-sharing-system',
      tags: [
        'Java',
        'OOP',
        'Strategy Pattern',
        'Design Patterns',
        'Layered Architecture'
      ],
      accentColor: 0xFFF4A261,
    ),
    Project(
      name: 'Tic Tac Toe',
      category: 'java',
      role: 'Developer',
      //period: 'July 2026',
      tagline: 'Console-Based Strategy Game',
      description:
      'Built a console-based Tic Tac Toe game in Java with two game modes — '
          'Player vs Player and Player vs Computer. '
          'The AI opponent uses randomized move selection for unpredictable gameplay.',
      bullets: [
        'Implemented Player vs Player and Player vs Computer modes',
        'Built AI opponent with randomized move logic',
        'Designed clean board rendering with input validation and error handling',
        'Applied OOP principles with modular class structure',
      ],
      github: 'https://github.com/Saket-01-bit/ticTacToe-Console-Based-',
      tags: ['Java', 'OOP', 'Game Logic', 'Console App'],
      accentColor: 0xFFF4A261,
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
    cgpa: '7.96 / 10',
    coursework: ['Data Structures', 'OOP', 'DBMS', 'Software Engineering'],
  );

  static const highSchoolEducation = Education(
    degree: 'Senior Secondary — Science Stream',
    institution: 'Government Model Senior Secondary School, Chandigarh',
    period: 'Apr 2020 – Mar 2022',
    cgpa: '',
    coursework: ['Physics', 'Chemistry', 'Mathematics', 'Computer Science'],
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
  final String category;
  const Project({
    required this.name,
    required this.role,
    this.period = '',
    required this.tagline,
    required this.description,
    required this.bullets,
    required this.github,
    required this.tags,
    required this.accentColor,
    this.category = 'flutter',
  });
}

class Certificate {
  final String title;
  final String issuer;
  final String year;
  const Certificate(
      {required this.title, required this.issuer, required this.year});
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
