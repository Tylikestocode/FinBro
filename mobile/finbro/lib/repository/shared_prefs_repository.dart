import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  // Save current User id
  Future<void> saveCurrentUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentUserId', userId);
  }

  // Get current User id
  Future<Map<String, int?>> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('currentUserId');
    return {'currentUserId': currentUserId};
  }

  // Delete current User id
  Future<void> deleteCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('currentUserId');
  }
}
