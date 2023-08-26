import 'package:flutter/material.dart';
import 'package:vasdolly_package_tools/config.dart';
import 'package:vasdolly_package_tools/route/router_helper.dart';

void main() async {
  await Config.init();
  runApp(RouterHelper.init());
}
