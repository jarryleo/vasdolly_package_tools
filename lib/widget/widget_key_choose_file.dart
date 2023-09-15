import 'package:file_picker/file_picker.dart';

import '../includes.dart';
import 'widget_key_input.dart';

class WidgetKeyChooseFile extends StatelessWidget {
  const WidgetKeyChooseFile(
      {super.key, required this.tips, this.controller, this.extraWidget});

  final String tips;
  final TextEditingController? controller;
  final Widget? extraWidget;

  @override
  Widget build(BuildContext context) {
    return KeyInputWidget(
      tips: '渠道文件:',
      controller: controller,
      extraWidget: IconButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            lockParentWindow: true,
            dialogTitle: tips,
            initialDirectory: controller?.text,
          );
          if (result != null) {
            controller?.text = result.files.single.path ?? '';
          }
        },
        icon: const Icon(Icons.folder_open),
      ),
    );
  }
}
