import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vasdolly_package_tools/constants.dart';
import 'package:vasdolly_package_tools/dialog/choose_sign_dialog.dart';
import 'package:vasdolly_package_tools/ext/string_ext.dart';
import 'package:vasdolly_package_tools/page/sign/sign_info.dart';

import '../../includes.dart';

class GlobalLogic extends GetxController {
  /// apk相关
  TextEditingController vasDollyPath = TextEditingController();
  TextEditingController outputDirPath = TextEditingController();
  TextEditingController channelPath = TextEditingController();
  TextEditingController apkSignerPath = TextEditingController();
  TextEditingController apkPath = TextEditingController();

  ///签名信息
  SignInfo signInfo = SignInfo();

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
    if (apkPath.text.isEmpty) {
      '请先选择未签名的apk'.showSnackBar();
      return;
    }
    if (apkSignerPath.text.isEmpty) {
      '请先选择签名工具'.showSnackBar();
      return;
    }

    showLoading();
    _saveConfig();
    _sign();
  }

  Future<void> buildChannelApk() async {
    if (apkPath.text.isEmpty) {
      '请选择要打渠道包的apk'.showSnackBar();
      return;
    }

    var path = apkPath.text;
    bool fileExists = await File(path).exists();
    if (!fileExists) {
      'apk路径错误'.showToast();
      return;
    }

    //判断apk是否签名
    showLoading();
    bool isSign = await _checkSign();
    if (!isSign) {
      //弹出选择签名文件弹框 todo
      SmartDialog.show(builder: (context) {
        return const ChooseSignInfoDialog();
      });
      hideLoading();
      return;
    }

    if (channelList.isEmpty) {
      '请先配置渠道'.showSnackBar();
      return;
    }

    if (outputDirPath.text.isEmpty) {
      '请先选择输出目录'.showSnackBar();
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
  }

  Future<ProcessResult> _executeCommand(
      String command, List<String> params) async {
    var result = await Process.run(command, params);
    if (kDebugMode) {
      print('command: $command');
      print('params: $params');
      print('stdout: ${result.stdout}');
      print('stderr: ${result.stderr}');
    }
    return result;
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
    if (cmd.isEmpty) {
      cmd = 'apksigner.jar'; //配置了环境变量的话
    }
    var singedApkPath = apkPath.text.replaceFirst('.apk', '_signed.apk');
    String keyStore = signInfo.storeFile ?? '';
    String keyStorePassword = signInfo.storePassword ?? '';
    String keyAlias = signInfo.keyAlias ?? '';
    String keyPassword = signInfo.keyPassword ?? '';
    var result = await _executeCommand(cmd, [
      'sign',
      '--v3-signing-enabled',
      'false',
      '--ks',
      keyStore,
      '--ks-pass',
      'pass:$keyStorePassword',
      '--ks-key-alias',
      keyAlias,
      '--key-pass',
      'pass:$keyPassword',
      '--out',
      singedApkPath,
      apkPath.text,
    ]);
    if (result.exitCode == 0) {
      apkPath.text = singedApkPath;
      '签名成功'.showSnackBar();
    } else {
      '签名失败'.showSnackBar();
    }
    hideLoading();
  }

  /// 构建渠道包
  /// java -jar ./Vasdolly.jar put -c $channel_file  $sign_apk $output_dir
  Future<void> _buildChannel() async {
    String vasDolly = vasDollyPath.text;
    if (vasDolly.isEmpty) {
      vasDolly = 'VasDolly.jar'; //如果设置了环境变量
    }
    var result = await _executeCommand('java', [
      '-jar',
      vasDolly,
      'put',
      '-c',
      channelPath.text,
      apkPath.text,
      outputDirPath.text,
    ]);
    if (result.exitCode == 0) {
      '生成渠道包成功'.showSnackBar();
    } else {
      '生成渠道包失败'.showSnackBar();
    }
    hideLoading();
  }

  ///检测apk是否已经签名
  Future<bool> _checkSign() async {
    var result = await _executeCommand('jarsigner', [
      '-verify',
      '-verbose',
      '-certs',
      apkPath.text,
    ]);

    var stdout = result.stdout as String?;
    if (result.exitCode != 0 || stdout == null) {
      '检测签名失败，请检测java环境变量是否配置。'.showSnackBar();
      return false;
    }

    var notSign = stdout.contains('未签名') || stdout.contains('unsigned');
    if (notSign) {
      'apk未签名'.showSnackBar();
    } else {
      'apk已签名'.showSnackBar();
    }
    return !notSign;
  }
}
