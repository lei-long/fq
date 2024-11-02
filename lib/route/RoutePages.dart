import 'package:fq/pages/question/question_view.dart';
import 'package:fq/pages/setting/setting_view.dart';
import 'package:fq/pages/web_view/web_view_view.dart';
import 'package:fq/route/RouteNames.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';
import '../pages/home/home_view.dart';
import '../pages/login/login_view.dart';
import '../pages/user/admin/admin_view.dart';
import '../pages/user/use/use_view.dart';
import '../welcome/welcome_view.dart';

class RoutePages {
  static final routes = [
    GetPage(
      name: RouteNames.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: RouteNames.home1,
      page: () => Home_Page(),
    ),
    GetPage(
      name: RouteNames.question,
      page: () => QuestionPage(),
    ),
    GetPage(
      name: RouteNames.welcome,
      page: () => WelcomePage(),
    ),

    GetPage(
      name: RouteNames.setting,
      page: () =>SettingPage (),
    ),

    GetPage(
      name: RouteNames.webView,
      page: () => WebViewPage(),
    ),
    GetPage(
      name: RouteNames.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteNames.use,
      page: () => UsePage(),
    ),
    GetPage(
      name: RouteNames.admin,
      page: () => AdminPage(),
    ),
  ];
}
