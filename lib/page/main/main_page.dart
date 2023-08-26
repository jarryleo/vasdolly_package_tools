import 'package:flutter/foundation.dart';
import 'package:vasdolly_package_tools/page/channel/channel_view.dart';
import 'package:vasdolly_package_tools/page/home/home_view.dart';
import 'package:vasdolly_package_tools/page/sign/sign_view.dart';

import '../../includes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Sign'),
            Tab(text: 'Channel'),
          ],
          onTap: (index) {
            if (kDebugMode) {
              print('index: $index');
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomePage(),
          SignPage(),
          ChannelPage(),
        ],
      ),
    );
  }
}
