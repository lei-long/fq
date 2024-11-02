import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic());
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 账号输入框
            TextField(
              controller: logic.usernameController,
              decoration: const InputDecoration(
                labelText: "账号",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 密码输入框
            TextField(
              controller: logic.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "密码",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 登录按钮
            ElevatedButton(
              onPressed: () {
                logic.onLogin(); // 调用登录逻辑
              },
              child: const Text("登录"),
            ),
            const SizedBox(height: 16),
            // 注册按钮
            ElevatedButton(
              onPressed: () {
                logic.onRegister(); // 调用注册逻辑
              },
              child: const Text("注册"),
            ),
          ],
        ),
      ),
    );
  }
}
