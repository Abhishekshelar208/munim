import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const Color bgDeep     = Color(0xFF060D1A);
  static const Color bgBase     = Color(0xFF0A1628);
  static const Color bgCard     = Color(0xFF0F1F38);
  static const Color bgCardAlt  = Color(0xFF122040);
  static const Color bgGlass    = Color(0x1AFFFFFF);
  static const Color bgGlassBorder = Color(0x26FFFFFF);

  // ── Brand Greens ─────────────────────────────────────────────────────────
  static const Color primaryGreen      = Color(0xFF00D4AA);
  static const Color primaryGreenLight = Color(0xFF33DDB9);
  static const Color primaryGreenDark  = Color(0xFF00A882);
  static const Color greenGlow         = Color(0x3300D4AA);
  static const Color greenDim          = Color(0x1A00D4AA);

  // ── Accent Blues ─────────────────────────────────────────────────────────
  static const Color accentBlue      = Color(0xFF6366F1);
  static const Color accentBlueDark  = Color(0xFF4F46E5);
  static const Color accentBlueLight = Color(0xFF818CF8);
  static const Color blueGlow        = Color(0x336366F1);

  // ── Gold / Premium ───────────────────────────────────────────────────────
  static const Color premiumGold      = Color(0xFFF59E0B);
  static const Color premiumGoldLight = Color(0xFFFBBF24);
  static const Color premiumGoldDark  = Color(0xFFD97706);
  static const Color goldGlow         = Color(0x33F59E0B);

  // ── Semantic ─────────────────────────────────────────────────────────────
  static const Color danger   = Color(0xFFEF4444);
  static const Color dangerBg = Color(0x1AEF4444);
  static const Color success  = Color(0xFF22C55E);
  static const Color warning  = Color(0xFFF59E0B);
  static const Color info     = Color(0xFF38BDF8);

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted     = Color(0xFF475569);
  static const Color textDisabled  = Color(0xFF334155);

  // ── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGreen, accentBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [premiumGold, Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [bgDeep, bgBase],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF122040), Color(0xFF0A1628)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [primaryGreen, Color(0xFF0EA5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
