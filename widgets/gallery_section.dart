import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection>
    with SingleTickerProviderStateMixin {
  GalleryCategory? _activeCategory; // null = show all
  late AnimationController _filterAnim;

  @override
  void initState() {
    super.initState();
    _filterAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _filterAnim.forward();
  }

  @override
  void dispose() {
    _filterAnim.dispose();
    super.dispose();
  }

  List<GalleryItem> get _filtered => _activeCategory == null
      ? GalleryData.items
      : GalleryData.byCategory(_activeCategory!);

  void _setCategory(GalleryCategory? cat) {
    if (cat == _activeCategory) return;
    _filterAnim.reverse().then((_) {
      setState(() => _activeCategory = cat);
      _filterAnim.forward();
    });
  }

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
          const SectionDivider(label: '05 — GALLERY'),

          // ── Header ─────────────────────────────────────────────
          RevealOnScroll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COLLEGE\nMEMORIES.',
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
                  'Events, participations, certificates & moments from CGC Landran.',
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // ── Category Filter Tabs ────────────────────────────────
          RevealOnScroll(
            delay: const Duration(milliseconds: 100),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'ALL',
                    icon: Icons.grid_view_rounded,
                    isActive: _activeCategory == null,
                    count: GalleryData.items.length,
                    onTap: () => _setCategory(null),
                  ),
                  const SizedBox(width: 10),
                  ...GalleryCategory.values.map((cat) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _FilterChip(
                          label: GalleryData.categoryLabels[cat]!,
                          icon: GalleryData.categoryIcons[cat]!,
                          isActive: _activeCategory == cat,
                          count: GalleryData.byCategory(cat).length,
                          onTap: () => _setCategory(cat),
                        ),
                      )),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // ── Grid ───────────────────────────────────────────────
          AnimatedBuilder(
            animation: _filterAnim,
            builder: (_, child) => Opacity(
              opacity: _filterAnim.value,
              child: Transform.translate(
                offset: Offset(0, (1 - _filterAnim.value) * 16),
                child: child,
              ),
            ),
            child: _filtered.isEmpty
                ? _EmptyState()
                : _GalleryGrid(items: _filtered),
          ),

          const SizedBox(height: 40),

          // ── Add photos CTA ─────────────────────────────────────
          RevealOnScroll(
            child: _AddPhotosBanner(),
          ),
        ],
      ),
    );
  }
}

// ── Filter chip ──────────────────────────────────────────────────────────────
class _FilterChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final int count;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.count,
    required this.onTap,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: active
                ? AppColors.accent
                : (_hovered ? const Color(0x1AFFFFFF) : const Color(0x0AFFFFFF)),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: active
                  ? AppColors.accent
                  : Colors.white.withOpacity(_hovered ? 0.2 : 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: active ? AppColors.background : Colors.white.withOpacity(0.7),
              ),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: active ? AppColors.background : Colors.white.withOpacity(0.7),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 7),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.background.withOpacity(0.2)
                      : Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${widget.count}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: active ? AppColors.background : Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Responsive grid ──────────────────────────────────────────────────────────
class _GalleryGrid extends StatelessWidget {
  final List<GalleryItem> items;
  const _GalleryGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cols = width > 1200 ? 4 : width > 900 ? 3 : width > 600 ? 2 : 2;
    final crossAxisSpacing = 12.0;
    final mainAxisSpacing = 12.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _GalleryCard(
        item: items[index],
        index: index,
        allItems: items,
      ),
    );
  }
}

// ── Gallery card ─────────────────────────────────────────────────────────────
class _GalleryCard extends StatefulWidget {
  final GalleryItem item;
  final int index;
  final List<GalleryItem> allItems;

  const _GalleryCard({
    required this.item,
    required this.index,
    required this.allItems,
  });

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _hovered = false;

  Color get _catColor {
    switch (widget.item.category) {
      case GalleryCategory.events:         return AppColors.accent;
      case GalleryCategory.participations: return const Color(0xFF4FC3F7);
      case GalleryCategory.certificates:   return const Color(0xFFFFD54F);
      case GalleryCategory.moments:        return const Color(0xFFCE93D8);
    }
  }

  void _openLightbox() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.92),
      builder: (_) => _Lightbox(
        items: widget.allItems,
        initialIndex: widget.index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      delay: Duration(milliseconds: 60 * (widget.index % 8)),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: _openLightbox,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..translate(0.0, _hovered ? -4.0 : 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? _catColor.withOpacity(0.5)
                    : Colors.white.withOpacity(0.08),
                width: 1,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: _catColor.withOpacity(0.12),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      )
                    ]
                  : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ── Photo ────────────────────────────────────────
                  _PhotoOrPlaceholder(
                    assetPath: widget.item.assetPath,
                    catColor: _catColor,
                    category: widget.item.category,
                  ),

                  // ── Hover overlay ────────────────────────────────
                  AnimatedOpacity(
                    opacity: _hovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── Always-visible bottom label ──────────────────
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(_hovered ? 0.0 : 0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: _catColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: _catColor.withOpacity(0.4)),
                            ),
                            child: Text(
                              GalleryData.categoryLabels[widget.item.category]!,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 8,
                                color: _catColor,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.item.title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.item.subtitle,
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.55),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Expand icon on hover ─────────────────────────
                  Positioned(
                    top: 12,
                    right: 12,
                    child: AnimatedOpacity(
                      opacity: _hovered ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.15)),
                        ),
                        child: const Icon(Icons.open_in_full,
                            size: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Photo widget with fallback placeholder ────────────────────────────────────
class _PhotoOrPlaceholder extends StatelessWidget {
  final String assetPath;
  final Color catColor;
  final GalleryCategory category;

  const _PhotoOrPlaceholder({
    required this.assetPath,
    required this.catColor,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.background,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Subtle grid pattern bg
            CustomPaint(painter: _GridPainter(color: catColor.withOpacity(0.04))),
            // Center icon
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: catColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: catColor.withOpacity(0.25)),
                  ),
                  child: Icon(
                    GalleryData.categoryIcons[category]!,
                    size: 22,
                    color: catColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'ADD PHOTO',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: catColor.withOpacity(0.4),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 1;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.color != color;
}

// ── Lightbox dialog ───────────────────────────────────────────────────────────
class _Lightbox extends StatefulWidget {
  final List<GalleryItem> items;
  final int initialIndex;

  const _Lightbox({required this.items, required this.initialIndex});

  @override
  State<_Lightbox> createState() => _LightboxState();
}

class _LightboxState extends State<_Lightbox> {
  late int _current;
  late PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _pageCtrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  Color get _catColor {
    switch (widget.items[_current].category) {
      case GalleryCategory.events:         return AppColors.accent;
      case GalleryCategory.participations: return const Color(0xFF4FC3F7);
      case GalleryCategory.certificates:   return const Color(0xFFFFD54F);
      case GalleryCategory.moments:        return const Color(0xFFCE93D8);
    }
  }

  void _prev() {
    if (_current > 0) {
      _pageCtrl.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _next() {
    if (_current < widget.items.length - 1) {
      _pageCtrl.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.items[_current];
    final isDesktop = MediaQuery.of(context).size.width > 700;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isDesktop ? 40 : 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Main card ──────────────────────────────────────────
          Container(
            constraints: BoxConstraints(
              maxWidth: 860,
              maxHeight: MediaQuery.of(context).size.height * 0.88,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: _catColor.withOpacity(0.2), width: 1),
              boxShadow: [
                BoxShadow(
                  color: _catColor.withOpacity(0.08),
                  blurRadius: 60,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Photo area
                  Flexible(
                    child: PageView.builder(
                      controller: _pageCtrl,
                      itemCount: widget.items.length,
                      onPageChanged: (i) => setState(() => _current = i),
                      itemBuilder: (_, i) {
                        final it = widget.items[i];
                        return Image.asset(
                          it.assetPath,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            height: 400,
                            color: AppColors.background,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  GalleryData.categoryIcons[it.category]!,
                                  size: 64,
                                  color: _catColor.withOpacity(0.3),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  it.title,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24,
                                    color: Colors.white.withOpacity(0.4),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Replace placeholder with your photo\nin assets/gallery/',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Info bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    decoration: BoxDecoration(
                      color: AppColors.background.withOpacity(0.8),
                      border: Border(
                          top: BorderSide(
                              color: Colors.white.withOpacity(0.08))),
                    ),
                    child: Row(
                      children: [
                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _catColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: _catColor.withOpacity(0.3)),
                          ),
                          child: Text(
                            GalleryData.categoryLabels[item.category]!,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 9,
                              color: _catColor,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                item.subtitle,
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.45),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Counter
                        Text(
                          '${_current + 1} / ${widget.items.length}',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.3),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Prev button ────────────────────────────────────────
          if (_current > 0)
            Positioned(
              left: isDesktop ? 0 : 4,
              child: _NavBtn(
                  icon: Icons.chevron_left, onTap: _prev, color: _catColor),
            ),

          // ── Next button ────────────────────────────────────────
          if (_current < widget.items.length - 1)
            Positioned(
              right: isDesktop ? 0 : 4,
              child: _NavBtn(
                  icon: Icons.chevron_right, onTap: _next, color: _catColor),
            ),

          // ── Close button ───────────────────────────────────────
          Positioned(
            top: 0,
            right: isDesktop ? 0 : 4,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.8),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),

          // ── Dot indicators ─────────────────────────────────────
          Positioned(
            bottom: 68,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.items.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _current ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _current
                        ? _catColor
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  const _NavBtn({required this.icon, required this.onTap, required this.color});

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.15)
                : AppColors.background.withOpacity(0.7),
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovered
                  ? widget.color.withOpacity(0.4)
                  : Colors.white.withOpacity(0.12),
            ),
          ),
          child: Icon(widget.icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_library_outlined,
              size: 40, color: Colors.white.withOpacity(0.15)),
          const SizedBox(height: 12),
          Text(
            'No photos in this category yet',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

// ── "How to add photos" banner ────────────────────────────────────────────────
class _AddPhotosBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add_photo_alternate_outlined,
                size: 20, color: AppColors.accent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ADD YOUR PHOTOS',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Drop photos into assets/gallery/{events,participations,certificates,moments}/ '
                  'and add entries in lib/data/portfolio_data.dart',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.35),
                    height: 1.6,
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
