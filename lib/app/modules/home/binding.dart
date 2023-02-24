import 'package:get/get.dart';
import 'package:getx_todo_list/app/data/providers/task/provider.dart';
import 'package:getx_todo_list/app/data/repository/task_repository.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(TaskRepository(TaskProvider())));
  }
}
