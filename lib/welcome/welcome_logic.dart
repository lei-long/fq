import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../database/database.dart'; // 假设这个是你的数据库类
import '../database/User.dart'; // 用户类
import '../route/RouteNames.dart'; // 路由名定义类

class WelcomeLogic extends GetxController {
  // 用户名和密码的控制器
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 数据库实例
  final UserDatabase db = UserDatabase();

  // 清理资源
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // 登录验证
  Future<void> onLogin() async {
    // 打印所有用户，方便调试
    List<User> allUsers = await db.getAllUsers();
    for (User user in allUsers) {
      print('User: ${user.username}, Password: ${user.password}');
    }
    print('All users in database: ${allUsers.map((u) => u.username).toList()}');

    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // 打印输入的用户名和密码
    print('Username: $username');
    print('Password: $password');

    // 输入验证
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('登录失败', '用户名和密码不能为空',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      print('Starting login for user: $username');

      User? user = await db.getUserByUsername(username); // 查询数据库中的用户

      // 如果数据库没有该用户
      if (user == null) {
        Get.snackbar('登录失败', '无此用户，请先注册',
            snackPosition: SnackPosition.BOTTOM);
        print('No user found for username: $username');
        return;
      }

      // 检查密码是否正确
      print('Checking password for user: $username');
      if (user.password == password) {
        // 用户名和密码匹配，跳转到主页
        print('Login successful');
        Get.offNamed(RouteNames.home); // 跳转到主页
      } else {
        // 用户名存在，但密码不正确
        print('Password mismatch for user: $username');
        Get.snackbar('登录失败', '用户名或密码错误',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // 处理可能的错误 (如数据库问题)
      print('Error during login: $e');
      Get.snackbar('错误', '无法完成登录，请稍后重试',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // 忘记密码处理
  void onForgotPassword() {
    Get.snackbar(
      "提示",
      "忘记密码功能暂未实现",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // 注册处理
  void onRegister() {
    Get.toNamed('/register'); // 跳转到注册页面
  }

  // 退出应用
  void onExit() {
    SystemNavigator.pop(); // 退出应用
  }
}
