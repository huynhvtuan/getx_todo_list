import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/core/values/colors.dart';
import 'package:getx_todo_list/app/data/models/task.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';
import 'package:getx_todo_list/app/widgets/list_icons.dart';
import 'package:dotted_border/dotted_border.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final listIcons = getIcons();
    var squareWith = Get.width - 12.0.wp;
    return Container(
      width: squareWith / 2,
      height: squareWith / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: Form(
                key: homeController.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homeController.editController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                          spacing: 2,
                          children: listIcons
                              .map((e) => Obx(() {
                                    final index = listIcons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.blue[200],
                                      pressElevation: 0,
                                      label: e,
                                      selected:
                                          homeController.chipIndex.value ==
                                              index,
                                      onSelected: (bool selected) {
                                        homeController.changeChipIndex(
                                            selected ? index : 0);
                                      },
                                    );
                                  }))
                              .toList()),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            minimumSize: const Size(150, 40)),
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            int icon = listIcons[homeController.chipIndex.value]
                                .icon!
                                .codePoint;
                            String color =
                                listIcons[homeController.chipIndex.value]
                                    .color!
                                    .toHex();
                            var task = Task(
                                title: homeController.editController.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homeController.addTask(task)
                                ? EasyLoading.showSuccess('Create Success')
                                : EasyLoading.showError('Duplicate Task');
                          }
                        },
                        child: const Text('Confirm')),
                  ],
                ),
              ));
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
