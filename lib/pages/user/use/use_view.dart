import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fq/pages/user/use/use_logic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(UseLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        elevation: 0,
      ),
      body: GetBuilder<UseLogic>(
        builder: (logic) {
          return ListView(
            children: [
              buildUser(context, logic),
              const SizedBox(height: 10),
              buildMenuList(context, logic),
            ],
          );
        },
      ),
    );
  }

  Widget buildUser(BuildContext context, UseLogic logic) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showImagePicker(context, logic),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: logic.userImagePath.isNotEmpty
                  ? FileImage(File(logic.userImagePath))
                  : const AssetImage('assets/images/e17.png') as ImageProvider,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => editName(context, logic),
                  child: Text(
                    logic.name.isNotEmpty ? logic.name : '默认',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => editSignature(context, logic),
                  child: Text(
                    logic.userSignature.isNotEmpty
                        ? logic.userSignature
                        : '默认',
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showImagePicker(BuildContext context, UseLogic logic) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('选择头像'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                child: const Text('从相册选择'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.gallery, logic);
                },
              ),
              TextButton(
                child: const Text('拍照'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.camera, logic);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, UseLogic logic) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        await logic.updateUserImage(File(pickedImage.path));
        Get.snackbar('成功', '头像已更新');
      }
    } catch (e) {
      Get.snackbar('错误', '选择图片失败: $e');
    }
  }

  void editSignature(BuildContext context, UseLogic logic) {
    TextEditingController _signatureController = TextEditingController();
    _signatureController.text = logic.userSignature;

    Get.defaultDialog(
      title: '编辑签名',
      content: TextField(
        controller: _signatureController,
        decoration: const InputDecoration(
          hintText: '输入您的新签名',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final newSignature = _signatureController.text.trim();
            if (newSignature.isNotEmpty) {
              await logic.updateUserSignature(newSignature);
              Get.snackbar('成功', '签名已更新');
              Get.back();
            } else {
              Get.snackbar('错误', '签名不能为空');
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }

  void editName(BuildContext context, UseLogic logic) {
    TextEditingController _nameController = TextEditingController();
    _nameController.text = logic.name;

    Get.defaultDialog(
      title: '编辑名字',
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          hintText: '输入您的新名字',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final newName = _nameController.text.trim();
            if (newName.isNotEmpty) {
              await logic.updateName(newName);
              Get.snackbar('成功', '名字已更新');
              Get.back();
            } else {
              Get.snackbar('错误', '名字不能为空');
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }

  Widget buildMenuList(BuildContext context, UseLogic logic) {
    return Column(
      children: [
        ListTile(
          title: const Text('修改密码'),
          onTap: () => changePassword(context, logic),
        ),
        ListTile(
          title: const Text('删除账号'),
          onTap: () => deleteUser(context, logic),
        ),
        ListTile(
          title: const Text('退出登录'),
          onTap: () {
            // Implement logout logic
          },
        ),
      ],
    );
  }

  void changePassword(BuildContext context, UseLogic logic) {
    TextEditingController _oldPasswordController = TextEditingController();
    TextEditingController _newPasswordController = TextEditingController();

    Get.defaultDialog(
      title: '修改密码',
      content: Column(
        children: [
          TextField(
            controller: _oldPasswordController,
            decoration: const InputDecoration(hintText: '旧密码'),
            obscureText: true,
          ),
          TextField(
            controller: _newPasswordController,
            decoration: const InputDecoration(hintText: '新密码'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final oldPassword = _oldPasswordController.text.trim();
            final newPassword = _newPasswordController.text.trim();

            if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
              final isValid = await logic.validateOldPassword(oldPassword);
              if (isValid) {
                await logic.updateUserPassword (oldPassword, newPassword);
                Get.snackbar('成功', '密码已更新');
                Get.back();
              } else {
                Get.snackbar('错误', '旧密码不正确');
              }
            } else {
              Get.snackbar('错误', '密码不能为空');
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }

  void deleteUser(BuildContext context, UseLogic logic) {
    Get.defaultDialog(
      title: '删除账号',
      content: const Text('确认删除账号吗？'),
      actions: [
        TextButton(
          onPressed: () {
            // Implement delete logic
            Get.back();
          },
          child: const Text('确认'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
      ],
    );
  }
}
