import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:telephony/telephony/repository.dart';

class ViewController extends GetxController {
  final isFetching = true.obs;
  final hasError = false.obs;
  final carrierName = ''.obs;
  final number = ''.obs;
  final countryIso = ''.obs;
  final simState = "".obs;
  // ignnecessary_overrides
  @override
  void onInit() {
    super.onInit();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      }
    });
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    try {
      final List<SimCard> simCard = ((await MobileNumber.getSimCards)!);
      final info = await const TelephonyRepository().getInfo();
      isFetching.value = false;
      simState.value = info;
      carrierName.value = simCard[0].carrierName ?? "not found";
      number.value = simCard[0].number ?? "not found";
      countryIso.value = simCard[0].countryIso ?? "not found";
    } on PlatformException catch (e) {
      isFetching.value = false;
      hasError.value = true;
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }
}
