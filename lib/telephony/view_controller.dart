import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony/repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class ViewController extends GetxController {
  final isFetching = true.obs;
  final hasError = false.obs;
  final carrierName = ''.obs;
  final number = ''.obs;
  final simState = "".obs;
  final phoneType = "".obs;
  final simSlotCount = "".obs;
  final subscriptionIdForSlot = "".obs;
  final deviceModel = "".obs;
  final isoCountryCode = "".obs;
  final mobileCountryCode = "".obs;
  final mobileNetworkCode = "".obs;
  // ignnecessary_overrides
  String get platform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "android";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return "ios";
    }
    return "unkonwn";
  }

  @override
  void onInit() {
    super.onInit();
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    try {
      //if platform is android
      if (platform == "android") {
        if ((await Permission.phone.request().isGranted) &&
            (await Permission.sms.request().isGranted)) {
          final info = await TelephonyRepository.getInfoAndroid();
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
      } else if (platform == "ios") {
        if ((await Permission.locationWhenInUse.request().isGranted) &&
            (await Permission.locationAlways.request().isGranted)) {
          final info = await TelephonyRepository.getInfoIOS();
          carrierName.value = info["carrierName"]!;
          deviceModel.value = info["deviceModel"]!;
          isoCountryCode.value = info["isoCountryCode"]!;
          mobileCountryCode.value = info["mobileCountryCode"]!;
          mobileNetworkCode.value = info["mobileNetworkCode"]!;
        } else {
          Get.defaultDialog(title: 'Give permission bruvvv!');
        }
      }
    } on PlatformException catch (e) {
      isFetching.value = false;
      hasError.value = true;
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }
}
