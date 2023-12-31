import 'package:file_picker/file_picker.dart';
import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

class WidgetChooseFile extends StatefulWidget {
  const WidgetChooseFile({
    super.key,
    this.controller,
    this.hintText,
    this.allowedExtensions,
    this.isDirectory = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final List<String>? allowedExtensions;
  final bool isDirectory;

  @override
  State<WidgetChooseFile> createState() => _WidgetChooseFileState();
}

class _WidgetChooseFileState extends State<WidgetChooseFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      padding: const EdgeInsets.only(left: 16, right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: QColors.mainColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Choose a file',
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(color: QColors.mainColor),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              chooseFile();
            },
            icon: const Icon(
              Icons.folder_open,
              color: QColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> chooseFile() async {
    if (widget.isDirectory) {
      final result = await FilePicker.platform.getDirectoryPath(
        lockParentWindow: true,
        dialogTitle: widget.hintText,
        initialDirectory: widget.controller?.text,
      );
      if (result != null) {
        widget.controller?.text = result;
      }
      return;
    }
    FilePickerResult? result;
    if (widget.allowedExtensions == null) {
      result = await FilePicker.platform.pickFiles(
        lockParentWindow: true,
        dialogTitle: widget.hintText,
        initialDirectory: widget.controller?.text,
      );
    } else {
      result = await FilePicker.platform.pickFiles(
        lockParentWindow: true,
        dialogTitle: widget.hintText,
        type: FileType.custom,
        allowedExtensions: widget.allowedExtensions,
        initialDirectory: widget.controller?.text,
      );
    }
    if (result != null) {
      widget.controller?.text = result.files.single.path ?? '';
    }
  }
}
