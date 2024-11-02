class User {
  final String username; // 用户名
  final String password; // 密码

  // 构造函数
  User({
    required this.username,
    required this.password,
  });

  // 将 User 对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
  // 从 Map 创建 User 对象
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
    );
  }
}
