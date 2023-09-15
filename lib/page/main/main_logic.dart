import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:vasdolly_package_tools/page/about/about_view.dart';
import 'package:vasdolly_package_tools/page/channel/channel_view.dart';
import 'package:vasdolly_package_tools/page/cloud/cloud_view.dart';
import 'package:vasdolly_package_tools/page/download/download_view.dart';
import 'package:vasdolly_package_tools/page/home/home_view.dart';
import 'package:vasdolly_package_tools/page/notify/notify_view.dart';
import 'package:vasdolly_package_tools/page/sign/sign_view.dart';

import '../../includes.dart';

class MainLogic extends GetxController {
  var tabs = ['渠道打包', '渠道配置', '签名配置', '云存储配置', '群通知配置', '下载配置', '关于'].obs;
  var pages = const [
    HomePage(),
    ChannelPage(),
    SignPage(),
    CloudPage(),
    NotifyPage(),
    DownloadPage(),
    AboutPage(),
  ];
  final CustomTabBarController tabBarController = CustomTabBarController();
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  void changePage(int index) {
    tabBarController.animateToIndex(index);
    pageController.jumpToPage(index);
  }
}
