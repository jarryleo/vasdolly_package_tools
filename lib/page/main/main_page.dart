import 'package:flutter_custom_tab_bar/library.dart';
import 'package:vasdolly_package_tools/page/main/main_logic.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';
import 'package:window_manager/window_manager.dart';

import '../../includes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var mainLogic = Get.find<MainLogic>();

  Widget getTabBarChild(BuildContext context, int index) {
    return TabBarItem(
      index: index,
      transform: ColorsTransform(
        highlightColor: QColors.mainText,
        normalColor: QColors.mainText,
        builder: (context, color) {
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 50),
            child: (Text(
              mainLogic.tabs[index],
              style: TextStyle(fontSize: 16, color: color),
            )),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: GestureDetector(
        onPanStart: (e) {
          windowManager.startDragging();
        },
        child: Container(
          //圆角
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: QColors.bodyBg,
          ),
          child: Row(
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'PKG',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 50,
                      color: QColors.mainColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CustomTabBar(
                        width: 150,
                        direction: Axis.vertical,
                        pageController: mainLogic.pageController,
                        tabBarController: mainLogic.tabBarController,
                        itemCount: mainLogic.tabs.length,
                        builder: getTabBarChild,
                        indicator: RoundIndicator(
                          color: QColors.contentBg,
                          radius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      windowManager.close();
                    },
                    icon: const Icon(Icons.power_settings_new),
                  ),
                  const Text('by: Jarry Leo'),
                  const SizedBox(height: 16),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 32, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: QColors.contentBg,
                  ),
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: mainLogic.pageController,
                    itemCount: mainLogic.pages.length,
                    itemBuilder: (context, index) {
                      return mainLogic.pages[index];
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
