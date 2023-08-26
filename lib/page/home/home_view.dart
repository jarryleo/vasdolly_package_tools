import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasdolly_package_tools/page/main/main_logic.dart';
import 'package:vasdolly_package_tools/widget/widget_choose_directory.dart';
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
    final logic = Get.find<MainLogic>();
    return Center(
      child: Card(
        child: Container(
          width: 720,
          height: 420,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetChooseFile(
                controller: logic.signedApkPath,
                hintText: 'Choose a signed apk file',
                allowedExtensions: const ['apk'],
              ),
              const SizedBox(height: 32),
              WidgetChooseDirectory(
                  controller: logic.outputDirPath,
                  hintText: 'Choose a output directory'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  logic.signApk();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                child: const Text(
                  'build channel apk',
                  style: TextStyle(
                    fontSize: 20,
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
