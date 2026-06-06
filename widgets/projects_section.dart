import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

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
          const SizedBox(height: 60),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: PortfolioData.projects.asMap().entries.map((entry) {
                final isLast = entry.key == PortfolioData.projects.length - 1;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 20),
                    child: RevealOnScroll(
                      delay: Duration(milliseconds: 150 * entry.key),
                      child: _ProjectCard(project: entry.value),
                    ),
                  ),
                );
              }).toList(),
            )
          else
            Column(
              children: PortfolioData.projects.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RevealOnScroll(
                    delay: Duration(milliseconds: 150 * entry.key),
                    child: _ProjectCard(project: entry.value),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

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
        transform: Matrix4.identity()..translate(0.0, _hovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0x1AFFFFFF) : const Color(0x0DFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? accent.withOpacity(0.4) : const Color(0x1AFFFFFF),
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.08),
                    blurRadius: 40,
                    spreadRadius: 0,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AccentTag(text: widget.project.role.toUpperCase(), color: accent),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse(widget.project.github)),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Icon(Icons.open_in_new, size: 14, color: Colors.white.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Project name
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

            // Description
            Text(
              widget.project.description,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: Colors.white.withOpacity(0.55),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 20),

            // Bullets
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

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.tags
                  .map((t) => AccentTag(text: t, color: accent))
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Period
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
