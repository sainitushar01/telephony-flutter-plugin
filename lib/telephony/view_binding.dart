import 'package:get/get.dart';
import 'package:telephony/telephony/view_controller.dart';

class ViewBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ViewController>()) Get.put(ViewController());
  }
}
