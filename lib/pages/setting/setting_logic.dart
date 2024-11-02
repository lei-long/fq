import 'package:get/get.dart';

class SettingLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 状态变量
  String selectedSubject = 'Java';
  String selectedSubject1 = '文本及样式';
  String selectedSubject2 = '线性布局';
  String selectedSubject3 = '填充';

  // 更新状态
  void setSelectedSubject(String value) {
    selectedSubject = value;
    update(); // 通知 GetBuilder 更新界面
  }

  void setSelectedSubject1(String value) {
    selectedSubject1 = value;
    update(); // 通知 GetBuilder 更新界面
  }

  void setSelectedSubject2(String value) {
    selectedSubject2 = value;
    update(); // 通知 GetBuilder 更新界面
  }

  void setSelectedSubject3(String value) {
    selectedSubject3 = value;
    update(); // 通知 GetBuilder 更新界面
  }
}
