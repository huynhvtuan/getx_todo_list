import 'package:get/get.dart';
import 'package:getx_todo_list/app/data/services/services.dart';

Future<void> initDependencyInjection() async {
  // Core
  Get.putAsync(() => StorageService().init());
}
