import 'package:file_picker/file_picker.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

class WidgetChooseDirectory extends StatefulWidget {
  const WidgetChooseDirectory({super.key, this.controller, this.hintText});

  final TextEditingController? controller;
  final String? hintText;

  @override
  State<WidgetChooseDirectory> createState() => _WidgetChooseDirectoryState();
}

class _WidgetChooseDirectoryState extends State<WidgetChooseDirectory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Choose a directory',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 32),
        IconButton(
          onPressed: () async {
            final result = await FilePicker.platform.getDirectoryPath(
              dialogTitle: widget.hintText ?? 'Choose a directory',
              initialDirectory: widget.controller?.text ?? '',
            );
            if (result != null) {
              widget.controller?.text = result;
            }
          },
          icon: const Icon(Icons.folder_open, color: QColors.mainColor),
        ),
      ],
    );
  }
}
