import 'test_users.dart';

class UserState {
  static TestUser? currentUser;

  static void setCurrentUser(String email, String password) {
    currentUser = TestUsers.users.firstWhere(
          (user) => user.email == email && user.password == password,
      orElse: () => TestUser(email: '', password: ''),
    );
  }

  static bool isLoggedIn() {
    return currentUser != null && currentUser!.email.isNotEmpty;
  }

  static void logout() {
    currentUser = null;
  }
} 