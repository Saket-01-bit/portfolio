import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const HeroSection({super.key, this.onViewProjects, this.onContact});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _glowController;
  bool _videoReady = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('https://stream.mux.com/tLkHO1qZoaaQOUeVWo8hEBeGQfySP02EPS02BmnNFyXys.m3u8'),
    )
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _videoReady = true);
          _videoController.setLooping(true);
          _videoController.setVolume(0);
          _videoController.play();
        }
      }).catchError((_) {
        // Video failed to load — fallback background still shows
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          // ── Video Background ──────────────────────────────────
          if (_videoReady)
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            ),

          // ── Fallback dark base (also sits behind video) ───────
          Positioned.fill(
            child: Container(color: AppColors.background),
          ),

          // ── Left-to-right gradient overlay ────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.background,
                    AppColors.background.withOpacity(0.85),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // ── Bottom gradient ───────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.35,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.background, Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Vertical Grid Lines (desktop only) ────────────────
          if (isDesktop)
            Positioned.fill(
              child: Row(
                children: [0.25, 0.5, 0.75].map((frac) {
                  return Positioned(
                    left: size.width * frac,
                    top: 0,
                    bottom: 0,
                    width: 1,
                    child: Container(
                      width: 1,
                      color: AppColors.gridLine,
                    ),
                  );
                }).toList().cast<Widget>(),
              ),
            ),

          // ── Central Glow Ellipse ──────────────────────────────
          Positioned(
            top: -60,
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (_, __) {
                final t = _glowController.value;
                return Opacity(
                  opacity: 0.35 + t * 0.15,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1A6B4A),
                          blurRadius: 80 + t * 20,
                          spreadRadius: 20,
                        ),
                        BoxShadow(
                          color: const Color(0xFF0D3D2A),
                          blurRadius: 120,
                          spreadRadius: 40,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Main Hero Content ─────────────────────────────────
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 80 : 24,
                ),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ── Left: text content ──────────────────
                          Expanded(
                            flex: 5,
                            child: _HeroLeftContent(
                              onViewProjects: widget.onViewProjects,
                              onContact: widget.onContact,
                            ),
                          ),
                          const SizedBox(width: 60),
                          // ── Right: photo ────────────────────────
                          Expanded(
                            flex: 4,
                            child: _HeroPhotoPanel()
                                .animate()
                                .fadeIn(delay: 600.ms, duration: 900.ms)
                                .slideX(begin: 0.15, end: 0, delay: 600.ms, duration: 900.ms, curve: Curves.easeOut),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: _HeroLeftContent(
                          onViewProjects: widget.onViewProjects,
                          onContact: widget.onContact,
                        ),
                      ),
              ),
            ),
          ),

          // ── Scroll Indicator ──────────────────────────────────
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'SCROLL',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: Colors.white.withOpacity(0.3),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ScrollArrow(),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 1400.ms, duration: 800.ms),
          ),
        ],
      ),
    );
  }

}

// ── Left column: all the text + CTA content ──────────────────────────────
class _HeroLeftContent extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const _HeroLeftContent({this.onViewProjects, this.onContact});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final fontSize = isDesktop ? 68.0 : 40.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 80),

        // Liquid Glass Card
        _LiquidGlassCard()
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms)
            .slideY(begin: -0.3, end: 0, delay: 200.ms, duration: 800.ms, curve: Curves.easeOut),

        const SizedBox(height: 16),

        // Eyebrow
        Text(
          'FLUTTER DEVELOPER · MOBILE ENGINEER',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: AppColors.accent,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: -0.1, end: 0, delay: 400.ms),

        const SizedBox(height: 20),

        // Headline
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'LAUNCH YOUR\n',
                style: GoogleFonts.playfairDisplay(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                  height: 1.0,
                ),
              ),
              TextSpan(
                text: 'FLUTTER\n',
                style: GoogleFonts.playfairDisplay(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  color: AppColors.accent,
                  letterSpacing: -2,
                  height: 1.05,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: 'CAREER',
                style: GoogleFonts.playfairDisplay(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                  height: 1.05,
                ),
              ),
              TextSpan(
                text: '.',
                style: GoogleFonts.playfairDisplay(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  color: AppColors.accent,
                  letterSpacing: -2,
                  height: 1.05,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 800.ms)
            .slideY(begin: 0.15, end: 0, delay: 500.ms, duration: 800.ms, curve: Curves.easeOut),

        const SizedBox(height: 28),

        // Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Building cross-platform Flutter apps that are fast, '
            'beautiful, and production-ready. Clean architecture. Real-time data. Consistent 60fps.',
            style: GoogleFonts.dmSans(
              fontSize: 15,
              color: Colors.white.withOpacity(0.65),
              height: 1.7,
            ),
          ),
        ).animate().fadeIn(delay: 700.ms, duration: 600.ms),

        const SizedBox(height: 40),

        // CTAs
        Row(
          children: [
            _CTAButton(
              label: 'VIEW PROJECTS',
              isPrimary: true,
              onTap: () => onViewProjects?.call(),
            ),
            const SizedBox(width: 16),
            _CTAButton(
              label: 'GITHUB',
              isPrimary: false,
              onTap: () => launchUrl(Uri.parse(PortfolioData.github)),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 900.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, delay: 900.ms),
      ],
    );
  }
}

// ── Right column: profile photo panel ────────────────────────────────────
class _HeroPhotoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: 340,
            height: 420,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.12),
                  blurRadius: 80,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),

          // Decorative arc / border frame
          Container(
            width: 320,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180),
              border: Border.all(
                color: AppColors.accent.withOpacity(0.15),
                width: 1,
              ),
            ),
          ),

          // Photo container — replace AssetImage with your actual photo path
          // e.g. Image.asset('assets/saket.jpg', ...) once you add it to pubspec
          ClipRRect(
            borderRadius: BorderRadius.circular(170),
            child: Container(
              width: 290,
              height: 370,
              decoration: BoxDecoration(
                color: const Color(0xFF0E1512),
                borderRadius: BorderRadius.circular(170),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.25),
                  width: 1.5,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ── IMAGE (properly constrained, no overflow/NaN) ──
                  Image.asset(
                    'assets/saket.jpg',
                    fit: BoxFit.cover,
                  ),

                  // ── Bottom Gradient Overlay ──
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF0E1512).withOpacity(0.85),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Name badge at bottom of photo
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.9),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Available for opportunities',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating stats badge top-right
          Positioned(
            top: 30,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x1AFFFFFF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '60fps',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.accent,
                    ),
                  ),
                  Text(
                    'Consistent',
                    style: GoogleFonts.dmSans(
                      fontSize: 9,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating stats badge top-left
          Positioned(
            top: 80,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x1AFFFFFF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '2+',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.accent,
                    ),
                  ),
                  Text(
                    'Apps Shipped',
                    style: GoogleFonts.dmSans(
                      fontSize: 9,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiquidGlassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0x03FFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0x1AFFFFFF),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.04),
            blurRadius: 0,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF5ED29C).withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '[ 2025 ]',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: const Color(0xFF5ED29C),
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Built by an\n',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'Industry',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' Engineer',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Clean architecture · Firebase · Provider/BLoC',
              style: GoogleFonts.dmSans(
                fontSize: 10,
                color: Colors.white.withOpacity(0.45),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _CTAButton({required this.label, required this.isPrimary, required this.onTap});

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hovered ? const Color(0xFF4BC589) : const Color(0xFF5ED29C))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : (_hovered ? const Color(0xFF5ED29C) : const Color(0x40FFFFFF)),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: widget.isPrimary ? const Color(0xFF070B0A) : Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              if (widget.isPrimary) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: Color(0xFF070B0A),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollArrow extends StatefulWidget {
  @override
  State<_ScrollArrow> createState() => _ScrollArrowState();
}

class _ScrollArrowState extends State<_ScrollArrow> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: 6).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _anim.value),
        child: Icon(Icons.keyboard_arrow_down, color: Colors.white.withOpacity(0.25), size: 20),
      ),
    );
  }
}
