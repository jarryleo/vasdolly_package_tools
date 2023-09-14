import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cloud_logic.dart';

class CloudPage extends StatelessWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CloudLogic());

    return Container();
  }
}
