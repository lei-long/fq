class UserHome {
  final String username;
  String password; // 密码可以更改
  final String name;
  final String signature; // 确保存在该属性
  final String imagePath; // 确保存在该属性
  UserHome({
    required this.username,
    required this.password,
    required this.name,
    required this.signature, // 使用正确的属性名
    required this.imagePath, // 使用正确的属性名
  });
  // 将 UserHome 实例转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'signature': signature, // 使用正确的属性名
      'imagePath': imagePath, // 使用正确的属性名
    };
  }
  // 将 Map 转换为 UserHome 实例
  factory UserHome.fromMap(Map<String, dynamic> map) {
    return UserHome(
      username: map['username'],
      password: map['password'],
      name: map['name'],
      signature: map['signature'], // 使用正确的属性名
      imagePath: map['imagePath'], // 使用正确的属性名
    );
  }
}
