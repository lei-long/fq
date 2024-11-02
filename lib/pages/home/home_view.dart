import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeLogic = Get.put(HomeLogic(), permanent: true); // 初始化 HomeLogic

    return GetBuilder<HomeLogic>(builder: (logic) {
      return Scaffold(
        body: logic.getCurrentPage(), // 显示当前页面
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: '首页'),
            NavigationDestination(icon: Icon(Icons.question_mark), label: '答题'),
            NavigationDestination(icon: Icon(Icons.settings), label: '设置'),
            NavigationDestination(icon: Icon(Icons.person), label: '个人'),
          ],
          selectedIndex: logic.currentIndex,
          onDestinationSelected: (int index) {
            logic.changeIndex(index); // 切换底部导航栏索引
          },
        ),
      );
    });
  }
}
