
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

import 'includes.dart';

class Config{
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
      size: Size(800, 800),
      minimumSize: Size(800, 800),
      center: true,
      skipTaskbar: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}