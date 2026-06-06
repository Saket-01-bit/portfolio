import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF070B0A);
  static const surface = Color(0xFF0E1512);
  static const surfaceCard = Color(0xFF111A16);
  static const accent = Color(0xFF5ED29C);
  static const accentDim = Color(0xFF2A6B4A);
  static const accentGlow = Color(0xFF1A4A35);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB0B8B4);
  static const textMuted = Color(0xFF5A6B62);
  static const gridLine = Color(0x1AFFFFFF);
  static const cardBorder = Color(0x26FFFFFF);
  static const cardBg = Color(0x0AFFFFFF);
  static const glassShine = Color(0x1AFFFFFF);
}

class AppTextStyles {
  static TextStyle display(double size) => GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: FontWeight.w900,
        color: AppColors.textPrimary,
        letterSpacing: -1.5,
        height: 1.0,
      );

  static TextStyle headline(double size) => GoogleFonts.spaceGrotesk(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle mono(double size) => GoogleFonts.jetBrainsMono(
        fontSize: size,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      );

  static TextStyle body(double size) => GoogleFonts.dmSans(
        fontSize: size,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  static TextStyle label(double size) => GoogleFonts.spaceGrotesk(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: AppColors.accent,
        letterSpacing: 2.0,
      );
}
