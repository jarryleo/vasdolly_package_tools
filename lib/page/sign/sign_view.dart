import 'package:file_picker/file_picker.dart';
import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/widget/button.dart';
import 'package:vasdolly_package_tools/widget/widget_key_input.dart';

import '../../includes.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage>
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
            KeyInputWidget(
              tips: 'Unsigned apk file:',
              controller: logic.unsignedApkPath,
              extraWidget: IconButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    logic.unsignedApkPath.text = result.files.single.path ?? '';
                  }
                },
                icon: const Icon(Icons.folder_open),
              ),
            ),
            const SizedBox(height: 16),
            KeyInputWidget(
              tips: 'Apksigner file:',
              controller: logic.apkSignerPath,
              extraWidget: IconButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    logic.apkSignerPath.text = result.files.single.path ?? '';
                  }
                },
                icon: const Icon(Icons.folder_open),
              ),
            ),
            const SizedBox(height: 16),
            KeyInputWidget(
              tips: 'Store file:',
              controller: logic.keyStorePath,
              extraWidget: IconButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    logic.keyStorePath.text = result.files.single.path ?? '';
                  }
                },
                icon: const Icon(Icons.folder_open),
              ),
            ),
            const SizedBox(height: 16),
            KeyInputWidget(
              tips: 'Store password:',
              controller: logic.keyStorePassword,
            ),
            const SizedBox(height: 16),
            KeyInputWidget(
              tips: 'Key alias:',
              controller: logic.aliasName,
            ),
            const SizedBox(height: 16),
            KeyInputWidget(
              tips: 'Key password:',
              controller: logic.aliasPassword,
            ),
            const SizedBox(height: 32),
            CButton(
              text: 'sign apk',
              size: 40,
              fullWidthButton: true,
              onPressed: () {
                logic.signApk();
              },
            ),
          ],
        ),
      ),
    );
  }
}
