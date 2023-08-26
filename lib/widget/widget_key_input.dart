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
          child: Text(widget.tips),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              if (widget.extraWidget != null) widget.extraWidget!,
            ],
          ),
        ),
      ],
    );
  }
}
