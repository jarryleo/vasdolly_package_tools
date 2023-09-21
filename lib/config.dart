import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

import 'includes.dart';

class Config {
  ///初始化
  static Future<void> init() async {
    //初始化存储
    await GetStorage.init();
    await initWindow();
  }

  ///初始化窗口设置
  static Future<void> initWindow() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Must add this line.
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: 'VasDolly Package Tools',
      size: Size(800, 600),
      minimumSize: Size(800, 600),
      center: true,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden, // 注释：去除窗口标题栏
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setBackgroundColor(Colors.transparent);
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAsFrameless();
    });
  }
}
