import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _activeTab = 'flutter';

  static const _tabs = [
    {'key': 'flutter', 'label': '⟨/⟩  FLUTTER'},
    {'key': 'java',    'label': '☕  JAVA'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    final filtered = PortfolioData.projects
        .where((p) => p.category == _activeTab)
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionDivider(label: '02 — PROJECTS'),
          RevealOnScroll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FEATURED\nWORK.',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isDesktop ? 56 : 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1.5,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Shipping production-grade apps with real-world impact.',
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // ── Tab switcher ────────────────────────────────────────
          RevealOnScroll(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _tabs.map((tab) {
                  final isActive = _activeTab == tab['key'];
                  final accent = tab['key'] == 'flutter'
                      ? AppColors.accent
                      : const Color(0xFFF4A261);
                  return GestureDetector(
                    onTap: () => setState(() => _activeTab = tab['key']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive
                            ? accent.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isActive
                              ? accent.withOpacity(0.35)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        tab['label']!,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: isActive
                              ? accent
                              : Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // ── Project cards ────────────────────────────────────────
          if (filtered.isEmpty)
            RevealOnScroll(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Text(
                    'No projects yet — check back soon.',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            )
          else if (isDesktop)
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = (constraints.maxWidth - 20) / 2; // 2 per row, 20px gap
                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: filtered.asMap().entries.map((entry) {
                    return SizedBox(
                      width: cardWidth,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 150 * entry.key),
                        child: _ProjectCard(project: entry.value),
                      ),
                    );
                  }).toList(),
                );
              },
            )
          else
      _MobileProjectPager(projects: filtered),
        ],
      ),
    );
  }
}

// ── Project card (unchanged from before) ──────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({super.key, required this.project});  // ← add super.key

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = Color(widget.project.accentColor);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, _hovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0x1AFFFFFF)
              : const Color(0x0DFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.4)
                : const Color(0x1AFFFFFF),
            width: 1,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: accent.withOpacity(0.08),
              blurRadius: 40,
              offset: const Offset(0, 8),
            ),
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AccentTag(
                    text: widget.project.role.toUpperCase(), color: accent),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse(widget.project.github)),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Icon(Icons.open_in_new,
                        size: 14,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.project.name,
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.project.tagline,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: accent.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.project.description,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: Colors.white.withOpacity(0.55),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 20),
            ...widget.project.bullets.map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7, right: 10),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.65),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.tags
                  .map((t) => AccentTag(text: t, color: accent))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              widget.project.period,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: Colors.white.withOpacity(0.25),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileProjectPager extends StatefulWidget {
  final List<Project> projects;
  const _MobileProjectPager({required this.projects});

  @override
  State<_MobileProjectPager> createState() => _MobileProjectPagerState();
}

class _MobileProjectPagerState extends State<_MobileProjectPager> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Wrap in IntrinsicHeight inside a SingleChildScrollView-safe approach:
        // Render all cards in an Offstage stack to measure, then size PageView
        _SizedPageView(
          controller: _pageController,
          projects: widget.projects,
          onPageChanged: (i) => setState(() => _currentPage = i),
        ),

        const SizedBox(height: 20),

        // Dot indicators
        if (widget.projects.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.projects.length, (i) {
              final isActive = i == _currentPage;
              final accent = Color(widget.projects[i].accentColor);
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isActive
                        ? accent
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }
}

class _SizedPageView extends StatefulWidget {
  final PageController controller;
  final List<Project> projects;
  final ValueChanged<int> onPageChanged;

  const _SizedPageView({
    required this.controller,
    required this.projects,
    required this.onPageChanged,
  });

  @override
  State<_SizedPageView> createState() => _SizedPageViewState();
}

class _SizedPageViewState extends State<_SizedPageView> {
  final List<double> _heights = [];
  int _currentPage = 0;

  double get _currentHeight {
    if (_heights.isEmpty) return 600; // fallback
    if (_currentPage >= _heights.length) return _heights.last;
    return _heights[_currentPage];
  }

  @override
  void initState() {
    super.initState();
    _heights.addAll(List.filled(widget.projects.length, 0));
    widget.controller.addListener(() {
      final page = widget.controller.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  void _onHeightMeasured(int index, double height) {
    if (_heights[index] != height) {
      setState(() => _heights[index] = height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _currentHeight == 0 ? 600 : _currentHeight,
      child: PageView.builder(
        controller: widget.controller,
        itemCount: widget.projects.length,
        onPageChanged: (i) {
          setState(() => _currentPage = i);
          widget.onPageChanged(i);
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _MeasuredCard(
              project: widget.projects[index],
              onHeight: (h) => _onHeightMeasured(index, h),
            ),
          );
        },
      ),
    );
  }
}

class _MeasuredCard extends StatefulWidget {
  final Project project;
  final ValueChanged<double> onHeight;
  const _MeasuredCard({required this.project, required this.onHeight});

  @override
  State<_MeasuredCard> createState() => _MeasuredCardState();
}

class _MeasuredCardState extends State<_MeasuredCard> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) widget.onHeight(box.size.height);
  }

  @override
  Widget build(BuildContext context) {
    return _ProjectCard(key: _key, project: widget.project);
  }
}