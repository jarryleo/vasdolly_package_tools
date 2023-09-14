import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

class QTheme {
  static ThemeData buildThemeData({bool isDarkMode = false}) {
    return ThemeData(
      primaryColor: isDarkMode ? QColors.mainColor : QColors.mainColor ,
    );
  }
}
