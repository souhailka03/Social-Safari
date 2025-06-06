class TestUser {
  final String email;
  final String password;

  TestUser({required this.email, required this.password});
}

class TestUsers {
  static final List<TestUser> users = [
    TestUser(email: 'test1@example.com', password: 'password123'),
    TestUser(email: 'test2@example.com', password: 'password456'),
    TestUser(email: 'user@test.com', password: 'test1234'),
    TestUser(email: 'admin@test.com', password: 'admin123'),
  ];

  static bool validateUser(String email, String password) {
    return users.any((user) => 
      user.email == email && user.password == password
    );
  }
} 