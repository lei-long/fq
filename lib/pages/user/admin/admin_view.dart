import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_logic.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AdminLogic());

    return Container();
  }
}
