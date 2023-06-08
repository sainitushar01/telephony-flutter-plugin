import 'package:flutter/services.dart';

class TelephonyRepository {
  const TelephonyRepository();
  final MethodChannel methodChannel = const MethodChannel('device_sim_info');
  Future<Map<String, String>> getInfo() async {
    try {
      final Map<String, String> info =
          await methodChannel.invokeMethod('getInfo');
      if (info.isEmpty) {
        return {'Error': 'Unable to get permission'};
      }
      return info;
    } on PlatformException catch (e) {
      return {
        'Error': e.toString(),
      };
    }
  }
}
