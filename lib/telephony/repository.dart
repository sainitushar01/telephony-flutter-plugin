import 'package:flutter/services.dart';
import "dart:developer" as dd;

class TelephonyRepository {
  const TelephonyRepository();
  final MethodChannel methodChannel = const MethodChannel('device_sim_info');

  Future<Map<String, String>> getInfo() async {
    try {
      final simState = await methodChannel.invokeMethod('getSimState');
      final phoneType = await methodChannel.invokeMethod('getPhoneType');
      final simSlotCount = await methodChannel.invokeMethod('getSimSlotCount');
      final getSID = await methodChannel.invokeMethod("getSubscriptionId");
      dd.log(getSID.toString());
      Map<String, String> info = {};
      info["simState"] = simState.toString();
      info["phoneType"] = phoneType.toString();
      info["simSlotCount"] = simSlotCount.toString();
      info["getSID"] = getSID.toString();
      return info;
    } on PlatformException catch (e) {
      return {
        "ERROR": e.toString(),
      };
    }
  }
}
