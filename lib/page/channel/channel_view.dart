import 'package:vasdolly_package_tools/page/main/global_logic.dart';
import 'package:vasdolly_package_tools/theme/text_styles.dart';
import 'package:vasdolly_package_tools/widget/panel.dart';
import 'package:vasdolly_package_tools/widget/widget_key_choose_file.dart';

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

  Widget channelFileChoose(GlobalLogic logic) {
    return Panel(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetKeyChooseFile(
          tips: '渠道文件:',
          controller: logic.channelPath,
        ),
        const SizedBox(height: 8),
        Text(
          'tips:选择渠道文件，文件类型为文本文件，每行一个渠道名称',
          style: QTextStyles.descStyle(),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final logic = Get.find<GlobalLogic>();
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            channelFileChoose(logic),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                return Panel(
                  child: ListView(
                    children: logic.channelList.map((e) {
                      return ListTile(
                        title: Text(e),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
