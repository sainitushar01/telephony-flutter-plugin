import 'package:flutter/services.dart';

class TelephonyRepository {
  const TelephonyRepository();
  final MethodChannel methodChannel = const MethodChannel('device_sim_info');

  Future<Map<String, String>> getInfo() async {
    try {
      final simState = await methodChannel.invokeMethod('getSimState');
      final phoneType = await methodChannel.invokeMethod('getPhoneType');
      final simSlotCount = await methodChannel.invokeMethod('getSimSlotCount');
      Map<String, String> info = {};
      info["simState"] = simState;
      info["phoneType"] = phoneType;
      info["simSlotCount"] = simSlotCount.toString();
      return info;
    } on PlatformException catch (e) {
      return {
        "ERROR": e.toString(),
      };
    }
  }
}
