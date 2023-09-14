import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/widget/button.dart';
import 'package:vasdolly_package_tools/widget/widget_choose_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final logic = Get.find<GlobalLogic>();
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetChooseFile(
              controller: logic.vasDollyPath,
              hintText: 'VasDolly.jar file path',
              allowedExtensions: const ['jar'],
            ),
            const SizedBox(height: 32),
            WidgetChooseFile(
              controller: logic.apkPath,
              hintText: 'Choose a signed apk',
              allowedExtensions: const ['apk'],
            ),
            const SizedBox(height: 32),
            WidgetChooseFile(
                controller: logic.outputDirPath,
                hintText: 'Choose a output directory',
                isDirectory: true),
            const SizedBox(height: 32),
            CButton(
              text: 'build channel apk',
              size: 48,
              fullWidthButton: true,
              onPressed: () {
                logic.buildChannelApk();
              },
            ),
          ],
        ),
      ),
    );
  }
}
