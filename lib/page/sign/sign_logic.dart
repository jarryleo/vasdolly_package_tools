import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vasdolly_package_tools/constants.dart';
import 'package:vasdolly_package_tools/page/sign/sign_info.dart';

import '../../includes.dart';

class SignLogic extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController storeFile = TextEditingController();
  TextEditingController storePassword = TextEditingController();
  TextEditingController keyAlias = TextEditingController();
  TextEditingController keyPassword = TextEditingController();

  List<SignInfo> signList = [];
  SignInfo? checkedSignInfo;

  @override
  void onReady() {
    super.onReady();
    _readSignInfoList();
  }

  void checked(SignInfo signInfo) {
    checkedSignInfo = signInfo;
    name.text = signInfo.name ?? '';
    storeFile.text = signInfo.storeFile ?? '';
    storePassword.text = signInfo.storePassword ?? '';
    keyAlias.text = signInfo.keyAlias ?? '';
    keyPassword.text = signInfo.keyPassword ?? '';
    update();
  }

  void removeSignInfo() {
    String n = name.text;
    signList.removeWhere((element) => element.name == n);
    _saveSignInfoList();
    update();
  }

  void saveSignInfo() {
    var info = SignInfo(
      name: name.text,
      storeFile: storeFile.text,
      storePassword: storePassword.text,
      keyAlias: keyAlias.text,
      keyPassword: keyPassword.text,
    );
    signList.removeWhere((element) => element.name == info.name);
    signList.add(info);
    _saveSignInfoList();
    update();
  }

  void _readSignInfoList() {
    signList.clear();
    var box = GetStorage();
    String? json = box.read(DataStoreKeys.keySignList);
    if (json == null) {
      return;
    }
    var listJson = jsonDecode(json);
    if (listJson != null) {
      var list = listJson.map((e) => SignInfo.fromJsonString(e)).toList();
      for (var item in list) {
        if (item is SignInfo) {
          signList.add(item);
        }
      }
    }
    update();
  }

  void _saveSignInfoList() {
    var box = GetStorage();
    List<String> listJson = signList.map((e) => e.toJsonString()).toList();
    String json = jsonEncode(listJson);
    box.write(DataStoreKeys.keySignList, json);
  }
}
