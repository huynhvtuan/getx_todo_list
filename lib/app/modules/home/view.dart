import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/core/values/colors.dart';
import 'package:getx_todo_list/app/data/models/task.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_card.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo_list/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          controller.obx((state) => Container()),
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My List',
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks.map((element) {
                  return LongPressDraggable(
                      data: element,
                      onDragStarted: () => controller.changeDeleting(true),
                      onDraggableCanceled: (_, __) =>
                          controller.changeDeleting(false),
                      onDragEnd: (_) => controller.changeDeleting(false),
                      feedback: Opacity(
                        opacity: 0.7,
                        child: TaskCard(task: element),
                      ),
                      child: TaskCard(task: element));
                }).toList(),
                AddCard()
              ],
            ),
          )
        ],
      )),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              onPressed: () =>
                  Get.to(() => AddDialog(), transition: Transition.downToUp),
              child:
                  Icon((controller.deleting.value) ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete task success');
        },
      ),
    );
  }
}
