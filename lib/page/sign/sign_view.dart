import 'package:file_picker/file_picker.dart';
import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/page/sign/sign_logic.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';
import 'package:vasdolly_package_tools/widget/button.dart';
import 'package:vasdolly_package_tools/widget/panel.dart';
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

  Widget editSignInfo() {
    return GetBuilder(builder: (SignLogic logic) {
      return Flexible(
        child: Panel(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeyInputWidget(
                  tips: 'name:',
                  controller: logic.name,
                ),
                const SizedBox(height: 12),
                KeyInputWidget(
                  tips: 'Store file:',
                  controller: logic.storeFile,
                  extraWidget: IconButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        logic.storeFile.text = result.files.single.path ?? '';
                      }
                    },
                    icon: const Icon(Icons.folder_open),
                  ),
                ),
                const SizedBox(height: 12),
                KeyInputWidget(
                  tips: 'Store password:',
                  controller: logic.storePassword,
                ),
                const SizedBox(height: 12),
                KeyInputWidget(
                  tips: 'Key alias:',
                  controller: logic.keyAlias,
                ),
                const SizedBox(height: 12),
                KeyInputWidget(
                  tips: 'Key password:',
                  controller: logic.keyPassword,
                ),
                const SizedBox(height: 16),
                CButton(
                  text: 'save',
                  size: 40,
                  fullWidthButton: true,
                  onPressed: () {
                    logic.saveSignInfo();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final logic = Get.put(SignLogic());
    final globalLogic = Get.find<GlobalLogic>();
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Panel(
              child: KeyInputWidget(
                tips: 'Apksigner file:',
                controller: globalLogic.apkSignerPath,
                extraWidget: IconButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      globalLogic.apkSignerPath.text =
                          result.files.single.path ?? '';
                    }
                  },
                  icon: const Icon(Icons.folder_open),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Row(
                children: [
                  Panel(
                    child: SizedBox(
                      width: 150,
                      child: GetBuilder<SignLogic>(
                        assignId: true,
                        builder: (logic) {
                          return ListView(
                            children: logic.signList.map((e) {
                              return ListTile(
                                title: Text(e.name ?? ''),
                                contentPadding: const EdgeInsets.all(0),
                                selected: logic.checkedSignInfo == e,
                                selectedTileColor: QColors.mainText,
                                trailing: logic.checkedSignInfo == e
                                    ? IconButton(
                                        onPressed: () {
                                          logic.removeSignInfo();
                                        },
                                        icon: const Icon(
                                          Icons.delete_forever,
                                        ),
                                      )
                                    : null,
                                onTap: () {
                                  logic.checked(e);
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  editSignInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
