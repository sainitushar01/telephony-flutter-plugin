import 'package:flutter/services.dart';
import 'dart:developer' as debug;

class TelephonyRepository {
  const TelephonyRepository();
  final MethodChannel methodChannel = const MethodChannel('device_sim_info');
  Future<dynamic> getInfo() async {
    try {
      final info = await methodChannel.invokeMethod('getInfo');
      debug.log(info);
      return info;
    } on PlatformException catch (e) {
      return e.toString();
    }
  }
}
