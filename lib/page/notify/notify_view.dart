import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notify_logic.dart';

class NotifyPage extends StatelessWidget {
  const NotifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotifyLogic());

    return Container();
  }
}
