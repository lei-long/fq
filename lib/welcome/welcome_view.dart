import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fq/welcome/welcome_logic.dart';
import 'package:get/get.dart';
import '../utils/images_utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 创建 WelcomeLogic 控制器的实例
    WelcomeLogic controller = Get.put(WelcomeLogic());

    return Scaffold(
      resizeToAvoidBottomInset: true, // 解决键盘弹出时覆盖输入框的问题
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(), // 点击返回按钮返回上一个页面
        ),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          children: [
            // 显示应用 logo 或欢迎图
            Image.asset(
              ImageUtils.getImagePath('e18'),
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40), // 空白间隔
            // 账号输入框
            _buildTextField(
              controller: controller.usernameController,
              labelText: '账号', // 输入框标签
              maxLength: 11, // 最大输入长度为 11
              inputType: TextInputType.phone, // 键盘类型为电话
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')), // 限制输入不能包含空格
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // 只允许输入数字
              ],
            ),
            // 密码输入框
            _buildTextField(
              controller: controller.passwordController,
              labelText: '密码', // 输入框标签
              obscureText: true, // 密码输入框显示为星号
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[\u4e00-\u9fa5]')), // 限制输入不能包含中文
              ],
            ),
            const SizedBox(height: 20), // 空白间隔
            // 操作按钮行
            _buildActionButtons(controller),
          ],
        ),
      ),
    );
  }

  // 构建输入框
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    int? maxLength,
    TextInputType? inputType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 16), // 上下边距
      decoration: BoxDecoration(
        color: Colors.white, // 背景色为白色
        borderRadius: BorderRadius.circular(28), // 圆角
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16), // 左右边距
        child: TextFormField(
          controller: controller, // 绑定控制器
          obscureText: obscureText, // 是否显示为密码输入
          maxLength: maxLength, // 最大长度
          keyboardType: inputType, // 键盘类型
          inputFormatters: inputFormatters, // 输入格式
          textAlign: TextAlign.center, // 文本居中显示
          decoration: InputDecoration(
            counterText: '', // 隐藏字符计数
            labelText: labelText, // 标签文本
            border: InputBorder.none, // 无边框
            contentPadding: EdgeInsets.symmetric(vertical: 15), // 内容内边距
          ),
        ),
      ),
    );
  }

  // 构建操作按钮
  Widget _buildActionButtons(WelcomeLogic controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 水平居中
      children: [
        _buildElevatedButton("登录", () => controller.onLogin()), // 登录按钮
        SizedBox(width: 20), // 间隔
        _buildElevatedButton("忘记密码", () => controller.onForgotPassword()), // 忘记密码按钮
        SizedBox(width: 20), // 间隔
        _buildElevatedButton("注册", () => controller.onRegister()), // 注册按钮
        SizedBox(width: 20), // 间隔
        _buildElevatedButton("退出", () => controller.onExit()), // 退出按钮
      ],
    );
  }

  // 构建按钮
  Widget _buildElevatedButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed, // 按钮点击事件
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // 圆角
        )),
        backgroundColor: MaterialStateProperty.all(Colors.white), // 背景色为白色
      ),
      child: Text(label), // 按钮文本
    );
  }
}
