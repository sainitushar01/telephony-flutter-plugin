import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony/repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ViewController extends GetxController {
  final isFetching = true.obs;
  final hasError = false.obs;
  final carrierName = ''.obs;
  final number = ''.obs;
  final simState = "".obs;
  final phoneType = "".obs;
  final simSlotCount = "".obs;
  final subscriptionIdForSlot = "".obs;
  // ignnecessary_overrides
  @override
  void onInit() {
    super.onInit();
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    try {
      if ((await Permission.phone.request().isGranted) &&
          (await Permission.sms.request().isGranted)) {
        final info = await const TelephonyRepository().getInfo();
        simState.value = info["simState"]!;
        phoneType.value = info["phoneType"]!;
        simSlotCount.value = info["simSlotCount"]!;
        carrierName.value = info["carrierName"]!;
        number.value = info["phoneNumber"]!;
        subscriptionIdForSlot.value = info["getSID"]!;
        isFetching.value = false;
      } else {
        Get.defaultDialog(title: 'Give permission bruvvv!');
      }
    } on PlatformException catch (e) {
      isFetching.value = false;
      hasError.value = true;
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }
}
