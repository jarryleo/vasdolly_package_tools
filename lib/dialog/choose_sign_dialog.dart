import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:vasdolly_package_tools/ext/string_ext.dart';
import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/page/main/main_logic.dart';
import 'package:vasdolly_package_tools/page/sign/sign_info.dart';
import 'package:vasdolly_package_tools/page/sign/sign_logic.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';
import 'package:vasdolly_package_tools/theme/text_styles.dart';
import 'package:vasdolly_package_tools/widget/button.dart';

import '../includes.dart';

class ChooseSignInfoDialog extends StatelessWidget {
  const ChooseSignInfoDialog({super.key, this.apkPath});

  final String? apkPath;

  @override
  Widget build(BuildContext context) {
    var signLogic = Get.put(SignLogic());
    var globalLogic = Get.find<GlobalLogic>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(16),
        child: signLogic.signList.isEmpty ? empty() : sign(globalLogic),
      ),
    );
  }

  Widget empty() {
    var mainLogic = Get.find<MainLogic>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '检测到Apk未签名，请先配置签名信息',
          style: QTextStyles.titleStyle(),
        ),
        const SizedBox(height: 16),
        CButton(
          size: 32,
          text: '确定',
          fullWidthButton: true,
          onPressed: () {
            mainLogic.changePage(2);
            SmartDialog.dismiss();
          },
        ),
      ],
    );
  }

  Widget sign(GlobalLogic globalLogic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '检测到当前Apk文件没有签名，请选择下面的签名文件进行签名',
          style: QTextStyles.titleStyle(),
        ),
        const SizedBox(height: 8),
        Text(
          'Apk文件位置：$apkPath',
          style: QTextStyles.descStyle(),
        ),
        const SizedBox(height: 8),
        GetBuilder<SignLogic>(
          builder: (logic) {
            return SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var signInfo in logic.signList) _buildItem(signInfo),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: () => SmartDialog.dismiss(),
              icon: const Icon(Icons.cancel_outlined),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CButton(
                size: 32,
                text: '签名',
                onPressed: () {
                  if (globalLogic.signInfo.value.name == null) {
                    '请选择签名文件'.showToast();
                    return;
                  }
                  SmartDialog.dismiss();
                  globalLogic.signApk();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildItem(SignInfo signInfo) {
    return GetBuilder<GlobalLogic>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.signInfo.value = signInfo;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: QColors.mainColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    value: signInfo.name ?? '',
                    activeColor: QColors.mainColor,
                    groupValue: logic.signInfo.value.name ?? '',
                    onChanged: (value) {
                      logic.signInfo.value = signInfo;
                    },
                  ),
                  Text(
                    signInfo.name ?? '',
                    style: QTextStyles.descStyle(
                        textColor: logic.signInfo.value.name == signInfo.name
                            ? QColors.mainColor
                            : null),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
