import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/transaction_model.dart';
import '../models/goal_model.dart';

class StorageService {
  static const String _userKey = 'muni_user';
  static const String _transactionsKey = 'muni_transactions';
  static const String _goalsKey = 'muni_goals';
  static const String _savingsKey = 'muni_total_savings';
  static const String _onboardedKey = 'muni_onboarding_done';
  static const String _themeKey = 'muni_theme_mode';
  static const String _languageKey = 'muni_language_code';

  // ── User ──────────────────────────────────────────────────────────────────
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  // ── Transactions ──────────────────────────────────────────────────────────
  Future<void> saveTransactions(List<TransactionModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(list.map((t) => t.toJson()).toList());
    await prefs.setString(_transactionsKey, encoded);
  }

  Future<List<TransactionModel>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_transactionsKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Goals ─────────────────────────────────────────────────────────────────
  Future<void> saveGoals(List<GoalModel> goals) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _goalsKey,
      jsonEncode(goals.map((g) => g.toJson()).toList()),
    );
  }

  Future<List<GoalModel>> loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_goalsKey);
    if (raw == null) return GoalModel.presets();
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => GoalModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Savings balance ───────────────────────────────────────────────────────
  Future<void> saveTotalSavings(double amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_savingsKey, amount);
  }

  Future<double> loadTotalSavings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_savingsKey) ?? 0.0;
  }

  // ── Onboarding ────────────────────────────────────────────────────────────
  Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardedKey) ?? false;
  }

  Future<void> markOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardedKey, true);
  }

  // ── Theme ─────────────────────────────────────────────────────────────────
  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_themeKey);
    return ThemeMode.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> saveLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, code);
  }

  Future<String> loadLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
