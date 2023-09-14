import '../includes.dart';
import 'strings_en_US.dart';
import 'strings_zh_CN.dart';

class Strings extends Translations {
  static const localeMap = {
    zhCNLocaleString: Locale('zh', 'CN'),
    enUSLocaleString: Locale('en', 'US'),
  };
  static const zhCNLocaleString = 'zh_CN';
  static const enUSLocaleString = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        zhCNLocaleString: zh_CN,
        enUSLocaleString: en_US,
      };
}
