import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const String
  _tokenKey =
      'auth_token';
  static const String
  _emailKey =
      'user_email';

  // Save authentication token
  static Future<
    bool
  >
  saveToken(
    String
    token,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(
        _tokenKey,
        token,
      );
    } catch (
      e
    ) {
      return false;
    }
  }

  // Get stored token
  static Future<
    String?
  >
  getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(
        _tokenKey,
      );
    } catch (
      e
    ) {
      return null;
    }
  }

  // Save user email
  static Future<
    bool
  >
  saveEmail(
    String
    email,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(
        _emailKey,
        email,
      );
    } catch (
      e
    ) {
      return false;
    }
  }

  // Get stored email
  static Future<
    String?
  >
  getEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(
        _emailKey,
      );
    } catch (
      e
    ) {
      return null;
    }
  }

  // Check if user is logged in
  static Future<
    bool
  >
  isLoggedIn() async {
    final token =
        await getToken();
    return token !=
            null &&
        token.isNotEmpty;
  }

  // Clear all stored data (logout)
  static Future<
    bool
  >
  clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(
        _tokenKey,
      );
      await prefs.remove(
        _emailKey,
      );
      return true;
    } catch (
      e
    ) {
      return false;
    }
  }
}
