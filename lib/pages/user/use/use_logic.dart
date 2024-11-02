import 'dart:io';
import 'package:get/get.dart';
import '../../../database/database.dart';
import '../../../database/userd.dart';

class UseLogic extends GetxController {
  String name = ''; // 用户姓名
  String username = ''; // 用户名
  String userSignature = ''; // 用户签名
  String userImagePath = ''; // 用户头像路径
  final UserDatabase database = UserDatabase(); // 用户数据库实例

  @override
  void onInit() {
    super.onInit();
    loadUserData(); // 初始化时加载用户数据
  }

  // 加载用户数据
  Future<void> loadUserData() async {
    print('尝试加载用户: $username'); // 添加调试输出
    final userHome = await database.getUserHomeByUsername(username);
    if (userHome != null) {
      name = userHome.name;
      userSignature = userHome.signature;
      userImagePath = userHome.imagePath;
      update();
    } else {
      Get.snackbar('错误', '用户数据加载失败: 用户未找到');
      print('用户未找到: $username'); // 添加调试输出
    }
  }


  // 更新用户姓名
  Future<void> updateName(String newName) async {
    if (newName.isEmpty) {
      Get.snackbar('错误', '名字不能为空'); // 错误提示
      return; // 如果名字为空，返回
    }
    name = newName; // 更新本地姓名
    await _updateUser(); // 更新数据库
  }

  // 更新用户签名
  Future<void> updateUserSignature(String newSignature) async {
    userSignature = newSignature; // 更新本地签名
    await _updateUser(); // 更新数据库
  }

  // 更新用户头像
  Future<void> updateUserImage(File image) async {
    userImagePath = image.path; // 更新本地头像路径
    await _updateUser(); // 更新数据库
  }

  // 更新用户信息到数据库
  Future<void> _updateUser() async {
    if (name.isEmpty) {
      Get.snackbar('错误', '名字不能为空'); // 错误提示
      return;
    }

    final updatedUser = UserHome(
      username: username, // 保留当前登录用户名
      password: '', // 如果不需要更改密码，可以留空
      name: name, // 更新的姓名
      signature: userSignature, // 更新的签名
      imagePath: userImagePath, // 更新的头像路径
    );

    try {
      int result = await database.updateUserHome(updatedUser); // 更新数据库中的用户信息
      if (result > 0) {
        update(); // 更新状态以反映 UI
        Get.snackbar('成功', '用户信息已更新'); // 成功提示
      } else {
        Get.snackbar('错误', '更新用户信息失败: 用户未找到'); // 错误提示
      }
    } catch (e) {
      Get.snackbar('错误', '更新用户信息失败: $e'); // 错误提示
    }
  }

  // 验证旧密码
  Future<bool> validateOldPassword(String oldPassword) async {
    final isValid = await database.validateOldPassword(username, oldPassword);
    if (!isValid) {
      Get.snackbar('错误', '旧密码不正确'); // 错误提示
    }
    return isValid;
  }

  // 更新用户密码
  Future<void> updateUserPassword(String oldPassword, String newPassword) async {
    // 首先验证旧密码
    if (await validateOldPassword(oldPassword)) {
      // 如果旧密码验证成功，则更新新密码
      await database.updateUserPassword(username, newPassword);
      Get.snackbar('成功', '密码已更新'); // 成功提示
    } else {
      Get.snackbar('错误', '无法更新密码'); // 错误提示
    }
  }
}
