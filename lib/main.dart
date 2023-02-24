import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo_list/app/app.dart';
import 'package:getx_todo_list/app/di/getx_di.dart';

void main() async {
  await GetStorage.init();
  await initDependencyInjection();
  runApp(const App());
}
