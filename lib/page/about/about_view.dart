import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_logic.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AboutLogic());

    return Container();
  }
}
