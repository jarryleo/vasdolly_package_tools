import 'package:get/get.dart';
import 'package:vasdolly_package_tools/route/routes.dart';

import '../page/main/main_binding.dart';
import '../page/main/main_page.dart';

abstract class Pages {
  static final pages = [
    GetPage(
        name: Routes.root,
        page: () => const MainPage(),
        binding: MainBinding()),
  ];
}
