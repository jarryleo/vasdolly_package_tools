import 'package:vasdolly_package_tools/includes.dart';
import 'package:vasdolly_package_tools/route/pages.dart';
import 'package:vasdolly_package_tools/route/routes.dart';

class RouterHelper {
  RouterHelper._internal();

  factory RouterHelper() => _instance;

  static final RouterHelper _instance = RouterHelper._internal();

  static const String appName = 'VasDolly Package Tools';

  static Widget init() {
    return GetMaterialApp(
      title: appName,
      initialRoute: Routes.root,
      getPages: Pages.pages,
      builder: (context, child) {
        return child ?? const SizedBox();
      },
    );
  }
}
