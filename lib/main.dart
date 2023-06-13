import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony/view.dart';
import 'package:telephony/telephony/view_binding.dart';
import 'package:telephony/telephony/view_controller.dart';

void main() {
  runApp(Telephony());
}

class Telephony extends StatelessWidget {
  Telephony({super.key});
  final controller = Get.put(ViewController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      getPages: [
        GetPage(
          name: '/sim-info',
          page: () {
            return const View();
          },
          binding: ViewBinding(),
        ),
      ],
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              Get.toNamed('/sim-info');
            },
            child: const Text('Check Telephony Manager'),
          ),
        ),
      ),
    );
  }
}
