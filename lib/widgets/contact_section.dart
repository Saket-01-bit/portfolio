import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      color: AppColors.surface,
      child: Stack(
        children: [
          // Background glow
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.05),
                    blurRadius: 150,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : 24,
              vertical: 100,
            ),
            child: Column(
              children: [
                const SectionDivider(label: '05 — CONTACT'),

                RevealOnScroll(
                  child: Column(
                    children: [
                      Text(
                        "LET'S BUILD\nSOMETHING.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: isDesktop ? 72 : 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -2,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Open to Flutter Developer roles, freelance projects,\nand exciting collaborations.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          height: 1.7,
                        ),
                      ),

                      const SizedBox(height: 48),

                      // ── CTA BUTTONS ROW ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SAY HELLO
                          GestureDetector(
                            onTap: () => launchUrl(
                              Uri.parse('mailto:${PortfolioData.email}'),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 18),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    AppColors.accent.withOpacity(0.25),
                                    blurRadius: 30,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SAY HELLO',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.background,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.arrow_forward,
                                      size: 16,
                                      color: AppColors.background),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // ── VIEW RESUME BUTTON ──
                          GestureDetector(
                            onTap: () => launchUrl(
                              Uri.parse(PortfolioData.resume),
                              mode: LaunchMode.externalApplication,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color:
                                  AppColors.accent.withOpacity(0.6),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.description_outlined,
                                    size: 18,
                                    color: AppColors.accent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'VIEW RESUME',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.accent,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 64),

                      // Social links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialLink(
                            label: 'GITHUB',
                            icon: Icons.code,
                            url: PortfolioData.github,
                          ),
                          const SizedBox(width: 32),
                          _SocialLink(
                            label: 'LINKEDIN',
                            icon: Icons.link,
                            url: PortfolioData.linkedin,
                          ),
                          const SizedBox(width: 32),
                          _SocialLink(
                            label: 'EMAIL',
                            icon: Icons.email_outlined,
                            url: 'mailto:${PortfolioData.email}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),

                // Footer
                Container(
                  padding: const EdgeInsets.only(top: 32),
                  decoration: const BoxDecoration(
                    border:
                    Border(top: BorderSide(color: Color(0x14FFFFFF))),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '© 2025 Saket Jain',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.25),
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        'BUILT WITH FLUTTER',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color:
                          AppColors.accent.withOpacity(0.5),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
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
class _SocialLink extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;

  const _SocialLink({
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0x1AFFFFFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.3)
                  : const Color(0x14FFFFFF),
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: _hovered
                    ? AppColors.accent
                    : Colors.white.withOpacity(0.4),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: _hovered
                      ? AppColors.accent
                      : Colors.white.withOpacity(0.4),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}