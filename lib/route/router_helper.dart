import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:vasdolly_package_tools/i18n/strings.dart';
import 'package:vasdolly_package_tools/includes.dart';
import 'package:vasdolly_package_tools/route/pages.dart';
import 'package:vasdolly_package_tools/route/routes.dart';
import 'package:vasdolly_package_tools/theme/theme.dart';

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
      theme: QTheme.buildThemeData(isDarkMode: false),
      darkTheme: QTheme.buildThemeData(isDarkMode: true),
      translations: Strings(),
      builder: (context, child) {
        return FlutterSmartDialog(child: child ?? Container());
      },
    );
  }
}
