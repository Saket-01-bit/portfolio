import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Offset offset;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 40),
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : Offset(widget.offset.dx / 100, widget.offset.dy / 100),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? borderColor;
  final Color? bgColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 16,
    this.borderColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0x0DFFFFFF),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? const Color(0x1AFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF5ED29C).withOpacity(0.03),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class AccentTag extends StatelessWidget {
  final String text;
  final Color? color;

  const AccentTag({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF5ED29C);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 10,
          color: c,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  final String label;

  const SectionDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Row(
        children: [
          const SizedBox(
            width: 32,
            child: Divider(color: Color(0x26FFFFFF), thickness: 1),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 10,
              color: Color(0xFF5A6B62),
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Divider(color: Color(0x26FFFFFF), thickness: 1),
          ),
        ],
      ),
    );
  }
}
