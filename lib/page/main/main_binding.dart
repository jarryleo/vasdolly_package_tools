import 'package:get/get.dart';
import 'package:vasdolly_package_tools/page/main/main_logic.dart';

import 'global_logic.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GlobalLogic(), fenix: true);
    Get.lazyPut(() => MainLogic());
  }
}
