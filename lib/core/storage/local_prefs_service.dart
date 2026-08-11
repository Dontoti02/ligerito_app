// lib/core/storage/local_prefs_service.dart
import 'package:ligerito/core/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Solo flags simples (onboarding visto, etc.). NUNCA tokens.
class LocalPrefsService {
  Future<bool> get onboardingVisto async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppStrings.keyOnboardingVisto) ?? false;
  }

  Future<void> marcarOnboardingVisto() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.keyOnboardingVisto, true);
  }
}
