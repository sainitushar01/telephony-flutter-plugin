import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_number/mobile_number.dart' as mobile;
import 'package:telephony/telephony/repository.dart';
import 'dart:developer' as developer;

class ViewController extends GetxController {
  final isFetching = true.obs;
  final hasError = false.obs;
  final carrierName = ''.obs;
  final number = ''.obs;
  final countryIso = ''.obs;
  final simState = "".obs;
  final phoneType = "".obs;
  final simSlotCount = "".obs;
  // ignnecessary_overrides
  @override
  void onInit() {
    super.onInit();
    mobile.MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      }
    });
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await mobile.MobileNumber.hasPhonePermission) {
      await mobile.MobileNumber.requestPhonePermission;
      return;
    }
    try {
      final List<mobile.SimCard> simCard =
          ((await mobile.MobileNumber.getSimCards)!);
      final info = await const TelephonyRepository().getInfo();
      simState.value = info["simState"]!;
      phoneType.value = info["phoneType"]!;
      simSlotCount.value = info["simSlotCount"]!;
      carrierName.value = simCard[0].carrierName ?? "not found";
      number.value = simCard[0].number ?? "not found";
      countryIso.value = simCard[0].countryIso ?? "not found";
      isFetching.value = false;
    } on PlatformException catch (e) {
      isFetching.value = false;
      hasError.value = true;
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }
}
