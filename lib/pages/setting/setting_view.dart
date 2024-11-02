import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  final List<String> data = ['Java', 'Dart', 'Python', 'C++', 'HTML'];
  final List<String> data1 = ['文本及样式', '按钮', '图片及ICON', '单选开关和复选框', '输入框和复选框', "输入框及表单", "进度指示器"];
  final List<String> data2 = ['线性布局', '弹性布局', '流式布局', '层叠布局', '对齐与相对定位', "LayoutBuilder和AfterLayout", "布局原理和约束"];
  final List<String> data3 = ['填充', '装饰容器', '变换', '容器组件', '裁剪', "空间适配", "页面骨架"];

  @override
  Widget build(BuildContext context) {
    // 初始化逻辑
    final logic = Get.put(SettingLogic());

    return Scaffold(
      appBar: AppBar(title: Text('设置页面')),
      body: GetBuilder<SettingLogic>(
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDropdownButton(
                  value: logic.selectedSubject,
                  items: data,
                  onChanged: (value) => logic.setSelectedSubject(value!),
                ),
                _buildDropdownButton(
                  value: logic.selectedSubject1,
                  items: data1,
                  onChanged: (value) => logic.setSelectedSubject1(value!),
                ),
                _buildDropdownButton(
                  value: logic.selectedSubject2,
                  items: data2,
                  onChanged: (value) => logic.setSelectedSubject2(value!),
                ),
                _buildDropdownButton(
                  value: logic.selectedSubject3,
                  items: data3,
                  onChanged: (value) => logic.setSelectedSubject3(value!),
                ),
                const SizedBox(height: 8),
                Text('你选择的语言是: ${logic.selectedSubject}'),
                Text('你选择的文本及样式是: ${logic.selectedSubject1}'),
                Text('你选择的布局是: ${logic.selectedSubject2}'),
                Text('你选择的容器是: ${logic.selectedSubject3}'),
              ],
            ),
          );
        },
      ),
    );
  }

  // 构建带宽度的下拉菜单
  Widget _buildDropdownButton({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true, // This makes the dropdown button fill the available width
        items: _buildMenuList(items),
        onChanged: onChanged,
      ),
    );
  }
  // 构建下拉菜单项
  List<DropdownMenuItem<String>> _buildMenuList(List<String> data) {
    return data.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
