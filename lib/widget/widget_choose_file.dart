import 'package:file_picker/file_picker.dart';

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
      padding: const EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Choose a file',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              chooseFile();
            },
            icon: const Icon(Icons.folder_open),
          ),
        ],
      ),
    );
  }

  Future<void> chooseFile() async {
    if (widget.isDirectory) {
      final result = await FilePicker.platform.getDirectoryPath(
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
        dialogTitle: widget.hintText,
        initialDirectory: widget.controller?.text,
      );
    } else {
      result = await FilePicker.platform.pickFiles(
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
