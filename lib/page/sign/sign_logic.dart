import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vasdolly_package_tools/constants.dart';
import 'package:vasdolly_package_tools/page/sign/sign_info.dart';

class SignLogic extends GetxController {
  List<SignInfo> signList = [];

  @override
  void onReady() {
    super.onReady();
    readSignInfoList();
  }

  @override
  void onClose() {}

  void addSignInfo(SignInfo info) {
    signList.add(info);
    saveSignInfoList();
    update();
  }

  void removeSignInfo(SignInfo info) {
    signList.remove(info);
    saveSignInfoList();
    update();
  }

  void readSignInfoList() {
    var box = GetStorage();
    List<String>? listJson = box.read(DataStoreKeys.keySignList);
    if (listJson != null) {
      var list = listJson.map((e) => SignInfo.fromJsonString(e)).toList();
      signList = list;
    }
    update();
  }

  void saveSignInfoList() {
    var box = GetStorage();
    List<String> listJson = signList.map((e) => e.toJsonString()).toList();
    box.write(DataStoreKeys.keySignList, listJson);
  }
}
