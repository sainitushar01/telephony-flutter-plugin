import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony/view.dart';
import 'package:telephony/telephony/view_binding.dart';

void main() {
  runApp(const Telephony());
}

class Telephony extends StatelessWidget {
  const Telephony({super.key});

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
            onPressed: () {
              Get.toNamed('/sim-info');
            },
            child: const Text('Check Telephony Manager'),
          ),
        ),
      ),
    );
  }
}
