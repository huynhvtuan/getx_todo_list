import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/core/values/colors.dart';
import 'package:getx_todo_list/app/data/models/task.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.editController.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close)),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        final task = homeCtrl.task.value;
                        if (task != null) {
                          var success = homeCtrl.updateTask(
                              task, homeCtrl.editController.text);
                          if (success) {
                            EasyLoading.showSuccess('Todo item add success');
                            Get.back();
                            homeCtrl.changeTask(null);
                            homeCtrl.editController.clear();
                          } else {
                            EasyLoading.showError('Todo item already exist');
                          }
                        } else {
                          EasyLoading.showError('Please select task');
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'News Task',
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                autofocus: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!)),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 5.0.wp, bottom: 3.0.wp, left: 5.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...homeCtrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () {
                          homeCtrl.changeTask(element);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0.wp, vertical: 2.0.wp),
                          child: Row(
                            children: [
                              Icon(
                                IconData(element.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(element.color),
                              ),
                              SizedBox(
                                width: 3.0.wp,
                              ),
                              Expanded(
                                child: Text(
                                  element.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (homeCtrl.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
