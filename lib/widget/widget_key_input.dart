import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

class KeyInputWidget extends StatefulWidget {
  const KeyInputWidget(
      {super.key, required this.tips, this.controller, this.extraWidget});

  final String tips;
  final TextEditingController? controller;
  final Widget? extraWidget;

  @override
  State<KeyInputWidget> createState() => _KeyInputWidgetState();
}

class _KeyInputWidgetState extends State<KeyInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(widget.tips, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: QColors.mainColor),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.extraWidget != null) widget.extraWidget!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
