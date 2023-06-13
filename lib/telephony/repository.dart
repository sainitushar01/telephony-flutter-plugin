import 'package:flutter/services.dart';

class TelephonyRepository {
  const TelephonyRepository();
  final MethodChannel methodChannel = const MethodChannel('device_sim_info');

  Future<Map<String, String>> getInfo() async {
    try {
      final simState = await methodChannel.invokeMethod('getSimState');
      final phoneType = await methodChannel.invokeMethod('getPhoneType');
      final simSlotCount = await methodChannel.invokeMethod('getSimSlotCount');
      final getSID = await methodChannel.invokeMethod("getSubscriptionId");
      final phoneNumber = await methodChannel.invokeMethod('getPhoneNumber');
      final carrierName = await methodChannel.invokeMethod('getCarrierName');
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
}
