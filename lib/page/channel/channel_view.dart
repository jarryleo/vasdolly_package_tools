import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/widget/widget_choose_file.dart';

import '../../includes.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final logic = Get.find<GlobalLogic>();
    return Center(
      child: Card(
        child: Container(
          width: 720,
          height: 620,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetChooseFile(
                controller: logic.channelPath,
                hintText: 'Choose a channel file',
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Obx(() {
                  return ListView(
                    children: logic.channelList.map((e) {
                      return ListTile(
                        title: Text(e),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
