import 'package:finbro/repository/shared_prefs_repository.dart';

class SharedPrefsService {
  final _sharedPrefsRepository = SharedPrefsRepository();

  // Save current User id
  Future<void> saveCurrentUserId(int userId) async {
    _sharedPrefsRepository.saveCurrentUserId(userId);
  }

  // Get current User id
  Future<int?> getCurrentUserId() async {
    Map<String, int?> map = await _sharedPrefsRepository.getCurrentUserId();
    return map['currentUserId'];
  }

  // Delete current User id
  Future<void> deleteCurrentUserId() async {
    await _sharedPrefsRepository.deleteCurrentUserId();
  }
}
