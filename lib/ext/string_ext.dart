import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

extension StringExt on String {
  void showToast() {
    if (trim().isNotEmpty) {
      SmartDialog.showToast(this, alignment: Alignment.center);
    }
  }

  void showSnackBar() {
    if (trim().isNotEmpty) {
      Get.snackbar("提示", this, colorText: QColors.mainText);
    }
  }
}
