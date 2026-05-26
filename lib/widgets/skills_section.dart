import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionDivider(label: '03 — SKILLS'),

          RevealOnScroll(
            child: Text(
              'TECHNICAL\nARSENAL.',
              style: GoogleFonts.playfairDisplay(
                fontSize: isDesktop ? 56 : 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.5,
                height: 1.05,
              ),
            ),
          ),

          const SizedBox(height: 60),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _SkillsGrid(),
                ),
                const SizedBox(width: 80),
                Expanded(
                  flex: 2,
                  child: _HighlightStats(),
                ),
              ],
            )
          else
            Column(
              children: [
                _SkillsGrid(),
                const SizedBox(height: 40),
                _HighlightStats(),
              ],
            ),
        ],
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: PortfolioData.skills.asMap().entries.map((entry) {
        return RevealOnScroll(
          delay: Duration(milliseconds: 80 * entry.key),
          child: _SkillCategory(category: entry.value),
        );
      }).toList(),
    );
  }
}

class _SkillCategory extends StatefulWidget {
  final SkillCategory category;
  const _SkillCategory({required this.category});

  @override
  State<_SkillCategory> createState() => _SkillCategoryState();
}

class _SkillCategoryState extends State<_SkillCategory> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0x1AFFFFFF) : const Color(0x0AFFFFFF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.3) : const Color(0x14FFFFFF),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category.label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: AppColors.accent,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...widget.category.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 3,
                        height: 3,
                        margin: const EdgeInsets.only(right: 8, top: 1),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          item,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _HighlightStats extends StatelessWidget {
  static const _stats = [
    ('15–30%', 'App performance improvement'),
    ('60fps', 'Consistent rendering'),
    ('2', 'Production apps shipped'),
    ('800+', 'Students mentored as VP'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BY THE\nNUMBERS.',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white.withOpacity(0.35),
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 32),
        ..._stats.asMap().entries.map((entry) => RevealOnScroll(
              delay: Duration(milliseconds: 100 * entry.key),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.value.$1,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: AppColors.accent,
                        letterSpacing: -1,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.value.$2,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.45),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(height: 1, color: const Color(0x14FFFFFF)),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
