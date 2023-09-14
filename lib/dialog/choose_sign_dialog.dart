import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/page/sign/sign_logic.dart';
import 'package:vasdolly_package_tools/theme/text_styles.dart';

import '../includes.dart';

class ChooseSignInfoDialog extends StatelessWidget {
  const ChooseSignInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var signLogic = Get.put(SignLogic());
    var globalLogic = Get.find<GlobalLogic>();
    return Card(
      child: Container(
        width: 300,
        height: 200,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              '检测到当前Apk文件没有签名，请选择下面的签名文件进行签名',
              style: QTextStyles.titleStyle(),
            )
          ],
        ),
      ),
    );
  }
}
