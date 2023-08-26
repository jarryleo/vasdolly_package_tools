import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  /// apk相关
  TextEditingController signedApkPath = TextEditingController();
  TextEditingController outputDirPath = TextEditingController();
  TextEditingController channelPath = TextEditingController();
  /// 签名相关
  TextEditingController keyStorePath = TextEditingController();
  TextEditingController keyStorePassword = TextEditingController();
  TextEditingController aliasName = TextEditingController();
  TextEditingController aliasPassword = TextEditingController();


  void signApk() {


  }

  Future<void> executeCommand(String command) async {
    var result = await Process.run(command, []);
    print(result.stdout);
  }

}
