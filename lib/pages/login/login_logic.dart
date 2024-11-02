import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/database.dart';
import '../../route/RouteNames.dart';
import '../../database/User.dart';

class LoginLogic extends GetxController {
  // 定义用户输入的控制/*器
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // 登录逻辑
  Future<void> onLogin() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('登录失败', '用户名和密码不能为空',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      UserDatabase db = UserDatabase();
      User? user = await db.getUserByUsername(username);

      if (user == null) {
        Get.snackbar('登录失败', "用户不存在",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (user.password != password) {
        Get.snackbar('登录失败', "用户名或密码错误",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      Get.offNamed(RouteNames.home); // 跳转到主页
    } catch (e) {
      Get.snackbar('错误', '无法完成登录，请稍后重试',
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  // 注册逻辑
  Future<void> onRegister() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "注册失败",
        "用户名和密码不能为空",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    UserDatabase db = UserDatabase();

    // 检查用户名是否已存在
    var existingUser = await db.getUserByUsername(username);
    if (existingUser != null) {
      Get.snackbar(
        "注册失败",
        "用户名已存在，请选择其他用户名",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 如果用户名不存在，则注册新用户
    await db.insertUser(User(username: username, password: password));
    Get.snackbar(
      "注册成功",
      "用户注册成功，请登录",
      snackPosition: SnackPosition.BOTTOM,
    );
    // 可选择导航到登录页面
    Get.offNamed('/login'); // 假设登录页面路由为 '/login'
  }
}
   