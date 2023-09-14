import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'download_logic.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(DownloadLogic());

    return Container();
  }
}
