import 'package:flutter/material.dart';
import 'package:fq/pages/user/use/use_view.dart';
import 'package:get/get.dart';
import '../question/question_view.dart';
import '../setting/setting_view.dart';
import 'home_page.dart';

class HomeLogic extends GetxController {
  int currentIndex = 0; // 当前选择的索引

  // 底部导航对应的页面
  late final List<Widget> widgets; // 声明为 late，以便在构造函数中初始化

  HomeLogic() {
    // 在构造函数中初始化 widgets
    widgets = [
      const Home_Page(), // 首页
      QuestionPage(),   // 问题页
      SettingPage(),    // 设置页
      UsePage(),        // 用户页
    ];
  }

  // 切换索引并更新状态
  void changeIndex(int index) {
    currentIndex = index;
    update(); // 通知依赖于该控制器的UI进行更新
  }

  // 获取当前显示的页面
  Widget getCurrentPage() {
    return widgets[currentIndex];
  }
}
