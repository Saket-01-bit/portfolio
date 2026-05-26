import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NavHeader extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, VoidCallback> navActions;

  const NavHeader({
    super.key,
    required this.scrollController,
    required this.navActions,
  });

  @override
  State<NavHeader> createState() => _NavHeaderState();
}

class _NavHeaderState extends State<NavHeader> with TickerProviderStateMixin {
  bool _menuOpen = false;
  bool _scrolled = false;
  late AnimationController _menuCtrl;
  late Animation<double> _menuAnim;

  static const _navItems = ['PROJECTS', 'SKILLS', 'ABOUT', 'RESUME'];

  @override
  void initState() {
    super.initState();
    _menuCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _menuAnim = CurvedAnimation(parent: _menuCtrl, curve: Curves.easeInOut);
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 60;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  void _toggleMenu() {
    setState(() => _menuOpen = !_menuOpen);
    _menuOpen ? _menuCtrl.forward() : _menuCtrl.reverse();
  }

  @override
  void dispose() {
    _menuCtrl.dispose();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Stack(
      children: [
        // ── Main Header Bar ──────────────────────────────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _scrolled ? AppColors.background.withOpacity(0.95) : Colors.transparent,
            border: _scrolled
                ? const Border(bottom: BorderSide(color: Color(0x1AFFFFFF), width: 1))
                : const Border(),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 24,
                vertical: 20,
              ),
              child: Row(
                children: [
                  // Logo
                  _Logo()
                      .animate()
                      .fadeIn(duration: 600.ms),

                  const Spacer(),

                  // Desktop Nav
                  if (isDesktop) ...[
                    ..._navItems.map((item) => _NavLink(
                          label: item,
                          onTap: widget.navActions[item],
                        )),
                    const SizedBox(width: 24),
                    _ContactButton(),
                  ] else ...[
                    // Hamburger
                    GestureDetector(
                      onTap: _toggleMenu,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _menuOpen ? Icons.close : Icons.menu,
                          key: ValueKey(_menuOpen),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // ── Mobile Full-Screen Menu Overlay ──────────────────────
        if (!isDesktop)
          AnimatedBuilder(
            animation: _menuAnim,
            builder: (_, __) {
              if (_menuAnim.value == 0) return const SizedBox.shrink();
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: -MediaQuery.of(context).size.height,
                child: Opacity(
                  opacity: _menuAnim.value,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: AppColors.background.withOpacity(0.97),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _navItems.asMap().entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: GestureDetector(
                                onTap: () {
                                  _toggleMenu();
                                  widget.navActions[entry.value]?.call();
                                },
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: _menuAnim.value),
                                  duration: Duration(milliseconds: 200 + entry.key * 60),
                                  builder: (_, v, child) => Opacity(
                                    opacity: v,
                                    child: Transform.translate(
                                      offset: Offset((1 - v) * 30, 0),
                                      child: child,
                                    ),
                                  ),
                                  child: Text(
                                    entry.value,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              'SJ',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.background,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'SAKET JAIN',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  const _NavLink({required this.label, this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _hovered ? AppColors.accent : Colors.white.withOpacity(0.6),
              letterSpacing: 1.5,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered ? AppColors.accent : Colors.white.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Text(
          'CONTACT',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _hovered ? AppColors.background : Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
