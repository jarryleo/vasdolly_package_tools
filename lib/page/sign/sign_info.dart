import 'dart:convert';

class SignInfo {
  String? name = ''; //配置名称
  String? storeFile = ''; //签名文件路径
  String? storePassword = ''; //签名文件密码
  String? keyAlias = ''; //别名
  String? keyPassword = ''; //别名密码

  SignInfo(
      {this.name,
      this.storeFile,
      this.storePassword,
      this.keyAlias,
      this.keyPassword});

  factory SignInfo.fromJsonString(String json) {
    return SignInfo.fromJson(jsonDecode(json));
  }

  factory SignInfo.fromJson(Map<String, dynamic> json) {
    return SignInfo(
        name: json['name'],
        storeFile: json['storeFile'],
        storePassword: json['storePassword'],
        keyAlias: json['keyAlias'],
        keyPassword: json['keyPassword']);
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'storeFile': storeFile,
      'storePassword': storePassword,
      'keyAlias': keyAlias,
      'keyPassword': keyPassword
    };
  }
}
