import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          const SectionDivider(label: '04 — ABOUT'),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _AboutText()),
                const SizedBox(width: 80),
                Expanded(flex: 4, child: _SideInfo()),
              ],
            )
          else
            Column(
              children: [
                _AboutText(),
                const SizedBox(height: 48),
                _SideInfo(),
              ],
            ),
          const SizedBox(height: 80),
          _LeadershipCard(),
          const SizedBox(height: 32),
          _CertificationsRow(),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT ME.',
            style: GoogleFonts.playfairDisplay(
              fontSize: isDesktop ? 56 : 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            PortfolioData.summary,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
              height: 1.8,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Currently pursuing B.Tech in Information Technology at CGC Landran '
            'while actively shipping real-world Flutter applications. '
            'Passionate about clean architecture, performance optimization, '
            'and building apps that users love.',
            style: GoogleFonts.dmSans(
              fontSize: 15,
              color: Colors.white.withOpacity(0.5),
              height: 1.8,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _ContactItem(
                  icon: Icons.email_outlined, label: PortfolioData.email),
              const SizedBox(width: 24),
              _ContactItem(
                  icon: Icons.location_on_outlined,
                  label: PortfolioData.location),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ContactItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.accent),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class _SideInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      delay: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Education Card
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.school_outlined,
                        size: 16, color: AppColors.accent),
                    const SizedBox(width: 8),
                    Text(
                      'EDUCATION',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        color: AppColors.accent,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  PortfolioData.education.degree,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  PortfolioData.education.institution,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.55),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  PortfolioData.education.period,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.3),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                /*Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.accent.withOpacity(0.25)),
                  ),
                  child: Text(
                    'CGPA: ${PortfolioData.education.cgpa}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),*/
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: PortfolioData.education.coursework
                      .map((c) => AccentTag(
                            text: c,
                            color: Colors.white.withOpacity(0.4),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          GlassCard(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.school_rounded,
                      size: 16, color: AppColors.accent),
                  const SizedBox(width: 8),
                  Text(
                    'HIGH SCHOOL EDUCATION',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: AppColors.accent,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                PortfolioData.highSchoolEducation.degree,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                PortfolioData.highSchoolEducation.institution,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.55),
                ),
              ),
              const SizedBox(height: 4),
              /*Text(
                PortfolioData.highSchoolEducation.period,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.3),
                  letterSpacing: 0.5,
                ),
              ),*/
              const SizedBox(height: 12),
              /*Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.accent.withOpacity(0.25)),
                  ),
                  child: Text(
                    'CGPA: ${PortfolioData.highSchoolEducation.cgpa}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),*/
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: PortfolioData.highSchoolEducation.coursework
                    .map((c) => AccentTag(
                          text: c,
                          color: Colors.white.withOpacity(0.4),
                        ))
                    .toList(),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class _LeadershipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.accent.withOpacity(0.08),
              const Color(0x0AFFFFFF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.accent.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.groups_outlined,
                      size: 18, color: AppColors.accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  // ← wrap Column in Expanded
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PortfolioData.leadership.role,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        PortfolioData.leadership.organization,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.accent.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AccentTag(
                          text:
                              PortfolioData.leadership.period), // ← moved here
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...PortfolioData.leadership.bullets.map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 7, right: 12),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          b,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                            height: 1.5,
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

class _CertificationsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CERTIFICATIONS',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            color: AppColors.textMuted,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 20),
        if (isDesktop)
          Row(
            children: PortfolioData.certifications
                .map((c) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _CertCard(cert: c),
                      ),
                    ))
                .toList(),
          )
        else
          Column(
            children: PortfolioData.certifications
                .map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _CertCard(cert: c),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

class _CertCard extends StatelessWidget {
  final Certificate cert;
  const _CertCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.accent.withOpacity(0.2)),
            ),
            child: const Icon(Icons.verified_outlined,
                size: 16, color: AppColors.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert.title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${cert.issuer} · ${cert.year}',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
