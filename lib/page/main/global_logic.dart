import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vasdolly_package_tools/constants.dart';

import '../../includes.dart';

class GlobalLogic extends GetxController {
  /// apk相关
  TextEditingController vasDollyPath = TextEditingController();
  TextEditingController signedApkPath = TextEditingController();
  TextEditingController outputDirPath = TextEditingController();
  TextEditingController channelPath = TextEditingController();
  TextEditingController apkSignerPath = TextEditingController();

  /// 签名相关
  TextEditingController unsignedApkPath = TextEditingController();
  TextEditingController keyStorePath = TextEditingController();
  TextEditingController keyStorePassword = TextEditingController();
  TextEditingController aliasName = TextEditingController();
  TextEditingController aliasPassword = TextEditingController();

  ///频道列表
  var channelList = [].obs;

  @override
  void onInit() {
    super.onInit();
    channelPath.addListener(() {
      if (channelPath.text.isNotEmpty) {
        _readChannelList();
      }
    });
    _readConfig();
  }

  void _readChannelList() {
    var file = File(channelPath.text);
    if (file.existsSync()) {
      var content = file.readAsStringSync();
      var list = content.split('\n');
      channelList.value = list;
    } else {
      channelList.value = [];
    }
  }

  void signApk() {
    if (unsignedApkPath.text.isEmpty) {
      Get.snackbar('提示', '请先选择未签名的apk');
      return;
    }
    if (apkSignerPath.text.isEmpty) {
      Get.snackbar('提示', '请先选择签名工具');
      return;
    }
    if (keyStorePath.text.isEmpty) {
      Get.snackbar('提示', '请先选择签名文件');
      return;
    }
    if (keyStorePassword.text.isEmpty) {
      Get.snackbar('提示', '请先输入签名文件密码');
      return;
    }
    if (aliasName.text.isEmpty) {
      Get.snackbar('提示', '请先输入别名');
      return;
    }
    if (aliasPassword.text.isEmpty) {
      Get.snackbar('提示', '请先输入别名密码');
      return;
    }
    showLoading();
    _saveConfig();
    _sign();
  }

  void buildChannelApk() {
    if (channelList.isEmpty) {
      Get.snackbar('提示', '请先选择渠道文件');
      return;
    }
    if (signedApkPath.text.isEmpty) {
      Get.snackbar('提示', '请先选择已签名的apk');
      return;
    }
    if (outputDirPath.text.isEmpty) {
      Get.snackbar('提示', '请先选择输出目录');
      return;
    }
    showLoading();
    _saveConfig();
    _buildChannel();
  }

  void showLoading() {
    SmartDialog.showLoading(msg: 'please wait...');
  }

  void hideLoading() {
    SmartDialog.dismiss();
  }

  void _saveConfig() {
    GetStorage box = GetStorage();
    box.write(DataStoreKeys.keyVasDollyPath, vasDollyPath.text);
    box.write(DataStoreKeys.keyChannelPath, channelPath.text);
    box.write(DataStoreKeys.keyApkSignerPath, apkSignerPath.text);
    box.write(DataStoreKeys.keyStorePath, keyStorePath.text);
    box.write(DataStoreKeys.keyStorePwd, keyStorePassword.text);
    box.write(DataStoreKeys.keyAlias, aliasName.text);
    box.write(DataStoreKeys.keyAliasPwd, aliasPassword.text);
  }

  void _readConfig() {
    GetStorage box = GetStorage();
    vasDollyPath.text = box.read(DataStoreKeys.keyVasDollyPath) ?? '';
    if (vasDollyPath.text.isEmpty) {
      //判断当前程序目录下是否存在VasDolly.jar，存在的话赋值路径到输入框
      var file = File('VasDolly.jar');
      if (file.existsSync()) {
        vasDollyPath.text = file.absolute.path;
      }
    }
    channelPath.text = box.read(DataStoreKeys.keyChannelPath) ?? '';
    apkSignerPath.text = box.read(DataStoreKeys.keyApkSignerPath) ?? '';
    keyStorePath.text = box.read(DataStoreKeys.keyStorePath) ?? '';
    keyStorePassword.text = box.read(DataStoreKeys.keyStorePwd) ?? '';
    aliasName.text = box.read(DataStoreKeys.keyAlias) ?? '';
    aliasPassword.text = box.read(DataStoreKeys.keyAliasPwd) ?? '';
  }

  Future<bool> _executeCommand(String command, List<String> params) async {
    var result = await Process.run(command, params);
    if (kDebugMode) {
      print('command: $command');
      print('params: $params');
      print('stdout: ${result.stdout}');
      print('stderr: ${result.stderr}');
    }
    return result.exitCode == 0;
  }

  ///签名apk指令
  /// apksigner
  /// sign
  /// --v3-signing-enabled false
  /// --ks $keyStore
  /// --ks-pass pass:$keyStore-pwd
  /// --ks-key-alias $alias
  /// --key-pass pass:$alias-pwd
  /// --out $sign_apk $input_apk
  Future<void> _sign() async {
    var cmd = apkSignerPath.text;
    var singedApkPath =
        unsignedApkPath.text.replaceFirst('.apk', '_signed.apk');
    var result = await _executeCommand(cmd, [
      'sign',
      '--v3-signing-enabled',
      'false',
      '--ks',
      keyStorePath.text,
      '--ks-pass',
      'pass:${keyStorePassword.text}',
      '--ks-key-alias',
      aliasName.text,
      '--key-pass',
      'pass:${aliasPassword.text}',
      '--out',
      singedApkPath,
      unsignedApkPath.text,
    ]);
    if (result) {
      signedApkPath.text = singedApkPath;
      Get.snackbar('提示', '签名成功');
    } else {
      Get.snackbar('提示', '签名失败');
    }
    hideLoading();
  }

  /// 构建渠道包
  /// java -jar ./Vasdolly.jar put -c $channel_file  $sign_apk $output_dir
  Future<void> _buildChannel() async {
    var result = await _executeCommand('java', [
      '-jar',
      vasDollyPath.text,
      'put',
      '-c',
      channelPath.text,
      signedApkPath.text,
      outputDirPath.text,
    ]);
    if (result) {
      Get.snackbar('提示', '生成渠道包成功');
    } else {
      Get.snackbar('提示', '生成渠道包失败');
    }
    hideLoading();
  }
}
