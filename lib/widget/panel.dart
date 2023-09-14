import 'package:vasdolly_package_tools/theme/colors.dart';

import '../includes.dart';

class Panel extends StatelessWidget {
  const Panel({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: QColors.panelBg,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: child,
    );
  }
}
