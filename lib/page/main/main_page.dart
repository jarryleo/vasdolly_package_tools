import 'package:flutter_custom_tab_bar/library.dart';
import 'package:vasdolly_package_tools/page/main/main_logic.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';

import '../../includes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  final CustomTabBarController _tabBarController = CustomTabBarController();
  var mainLogic = Get.find<MainLogic>();

  Widget getTabBarChild(BuildContext context, int index) {
    return TabBarItem(
        transform: ColorsTransform(
          highlightColor: Colors.white,
          normalColor: Colors.black,
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
        index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
              Flexible(
                child: CustomTabBar(
                  tabBarController: _tabBarController,
                  width: 150,
                  direction: Axis.vertical,
                  itemCount: mainLogic.tabs.length,
                  builder: getTabBarChild,
                  indicator: RoundIndicator(
                    color: QColors.mainColor,
                    radius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  pageController: _pageController,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16),
              child: PageView.builder(
                allowImplicitScrolling: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: mainLogic.pages.length,
                itemBuilder: (context, index) {
                  return mainLogic.pages[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
