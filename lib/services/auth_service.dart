import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../data/mock_data.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  // Initialize with Wali Kelas or default
  void initDefault() {
    _currentUser = MockData.accounts.firstWhere((a) => a.role == UserRole.walikelas);
    notifyListeners();
  }

  bool login(String usernameOrNip, String password) {
    final cleanInput = usernameOrNip.trim().toLowerCase();
    final cleanPass = password.trim();

    for (final acc in MockData.accounts) {
      final matchUser = acc.username.toLowerCase() == cleanInput;
      final matchNip = acc.nip.startsWith(cleanInput) || acc.nip == cleanInput;
      final matchAlias = (acc.role == UserRole.admin && (cleanInput == 'admin' || cleanInput == 'admintu')) ||
          (acc.role == UserRole.walikelas && (cleanInput == 'wali' || cleanInput == '19840212')) ||
          (acc.role == UserRole.kepsek && (cleanInput == 'kepsek' || cleanInput == '19671108')) ||
          (acc.role == UserRole.guru && cleanInput == 'guru');

      if ((matchUser || matchNip || matchAlias) && acc.password == cleanPass) {
        _currentUser = acc;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void switchRole(UserRole role) {
    final acc = MockData.accounts.firstWhere(
      (a) => a.role == role,
      orElse: () => MockData.accounts.first,
    );
    _currentUser = acc;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
