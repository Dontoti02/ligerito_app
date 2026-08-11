// lib/core/theme/text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';

class LigeritoTextStyles {
  LigeritoTextStyles._();

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: LigeritoColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: LigeritoColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: LigeritoColors.textPrimary,
      );

  static TextStyle get bodySecondary => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: LigeritoColors.textSecondary,
      );

  static TextStyle get price => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: LigeritoColors.primary,
      );
}
