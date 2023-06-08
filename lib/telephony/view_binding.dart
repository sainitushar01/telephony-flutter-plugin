import 'package:get/get.dart';
import 'package:telephony/telephony/view_controller.dart';

class ViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewController());
  }
}
