import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  String? _token;
  // Splash page
  bool _isLoading = true;
  // For Onboarding page
  bool _isOnboardingComplete = false;
  SharedPreferences? _prefs;

  String? get token => _token;
  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  bool get isOnboardingComplete => _isOnboardingComplete;
  SharedPreferences get storage => _prefs!;

  Future<void> initializeApp() async {
    _prefs ??= await SharedPreferences.getInstance();
    _isOnboardingComplete = _prefs?.getBool('onboardingComplete') ?? false;
    await Future.delayed(const Duration(seconds: 3));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await _prefs?.setBool('onboardingComplete', true);
    _isOnboardingComplete = true;
    notifyListeners();
  }

  void login(String token) {
    _token = token;
    notifyListeners();
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
