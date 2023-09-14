import 'package:file_picker/file_picker.dart';
import 'package:vasdolly_package_tools/page/main/global_logic.dart';
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
      child: Card(
        child: Container(
          width: 720,
          height: 620,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KeyInputWidget(
                tips: 'unsigned apk path:',
                controller: logic.unsignedApkPath,
                extraWidget: IconButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      logic.unsignedApkPath.text =
                          result.files.single.path ?? '';
                    }
                  },
                  icon: const Icon(Icons.folder_open),
                ),
              ),
              const SizedBox(height: 16),
              KeyInputWidget(
                tips: 'apksigner path:',
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
                tips: 'key store path:',
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
                tips: 'key store password:',
                controller: logic.keyStorePassword,
              ),
              const SizedBox(height: 16),
              KeyInputWidget(
                tips: 'alias:',
                controller: logic.aliasName,
              ),
              const SizedBox(height: 16),
              KeyInputWidget(
                tips: 'alias password:',
                controller: logic.aliasPassword,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  logic.signApk();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                child: const Text(
                  'sign apk',
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
