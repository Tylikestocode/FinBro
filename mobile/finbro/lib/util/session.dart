import 'package:finbro/domain/user.dart';

class Session {
  User currentUser;

  // Private named constructor
  Session._({required this.currentUser});

  // Static instance variable
  static Session? _instance;

  // Static method to access the singleton instance
  static Session getInstance({User? currentUser}) {
    if (_instance == null) {
      if (currentUser == null) {
        throw Exception('currentUser must be provided the first time.');
      }
      _instance = Session._(currentUser: currentUser);
    }
    return _instance!;
  }
}
