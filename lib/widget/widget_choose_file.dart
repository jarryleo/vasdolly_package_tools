import 'package:file_picker/file_picker.dart';

import '../includes.dart';

class WidgetChooseFile extends StatefulWidget {
  const WidgetChooseFile(
      {super.key, this.controller, this.hintText, this.allowedExtensions});

  final TextEditingController? controller;
  final String? hintText;
  final List<String>? allowedExtensions;

  @override
  State<WidgetChooseFile> createState() => _WidgetChooseFileState();
}

class _WidgetChooseFileState extends State<WidgetChooseFile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Choose a file',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 32),
        IconButton(
          onPressed: () async {
            FilePickerResult? result;
            if (widget.allowedExtensions == null) {
              result = await FilePicker.platform.pickFiles();
            } else {
              result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: widget.allowedExtensions,
              );
            }
            if (result != null) {
              widget.controller?.text = result.files.single.path ?? '';
            }
          },
          icon: const Icon(Icons.folder_open),
        ),
      ],
    );
  }
}
