import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final homeCtrk = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back))
            ],
          )
        ],
      ),
    );
  }
}
