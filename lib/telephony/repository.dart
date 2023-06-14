import 'package:flutter/services.dart';
import 'dart:developer' as dd;

class TelephonyRepository {
  static const methodChannel =
      MethodChannel('sim.flutter.methodchannel/android');
  static const platformChannel = MethodChannel('sim.flutter.methodchannel/ios');
  static Future<Map<String, String>> getInfoAndroid() async {
    try {
      final simSlotCount = await methodChannel.invokeMethod('getSimSlotCount');
      final phoneNumber = await methodChannel.invokeMethod('getPhoneNumber');
      final carrierName = await methodChannel.invokeMethod('getCarrierName');
      final getSID = await methodChannel.invokeMethod("getSubscriptionId");
      final phoneType = await methodChannel.invokeMethod('getPhoneType');
      final simState = await methodChannel.invokeMethod('getSimState');
      Map<String, String> info = {};
      info["simState"] = simState.toString();
      info["phoneType"] = phoneType.toString();
      info["simSlotCount"] = simSlotCount.toString();
      info["getSID"] = getSID.toString();
      info["carrierName"] = carrierName.toString();
      info["phoneNumber"] = phoneNumber.toString();
      return info;
    } on PlatformException catch (e) {
      return {
        "ERROR": e.toString(),
      };
    }
  }

  static Future<Map<String, String>> getInfoIOS() async {
    try {
      final deviceModel = await platformChannel.invokeMethod('getDeviceModel');
      final carrierName = await platformChannel.invokeMethod("getCarrierName");
      final mobileCountryCode =
          await platformChannel.invokeMethod("getMobileCountryCode");
      final mobileNetworkCode =
          await platformChannel.invokeMethod("getMobileNetworkCode");
      final isoCountryCode =
          await platformChannel.invokeMethod("getIsoCountryCode");
      dd.log(deviceModel);
      Map<String, String> info = {};
      info["deviceModel"] = deviceModel.toString();
      info["carrierName"] = carrierName.toString();
      info["isoCountryCode"] = isoCountryCode.toString();
      info["mobileCountryCode"] = mobileCountryCode.toString();
      info["mobileNetworkCode"] = mobileNetworkCode.toString();

      return info;
    } on PlatformException catch (e) {
      return {
        "ERROR": e.toString(),
      };
    }
  }
}
