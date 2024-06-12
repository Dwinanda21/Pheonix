import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  static Future<void> saveProfilePicturePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_picture_path', path);
  }

  static Future<String?> getProfilePicturePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_picture_path');
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_picture_path');
    await prefs.remove('username');
  }
}
