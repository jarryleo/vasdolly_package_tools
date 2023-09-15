import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

class QTextStyles {
  static TextStyle titleStyle() => const TextStyle(
      color: QColors.mainText, fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle descStyle({Color? textColor}) => TextStyle(
      color: textColor ?? QColors.secondaryText,
      fontSize: 14,
      fontWeight: FontWeight.w400);
}
