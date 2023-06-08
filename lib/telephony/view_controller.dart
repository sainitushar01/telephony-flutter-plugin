import 'package:get/get.dart';
import 'package:telephony/telephony/repository.dart';

class ViewController extends GetxController {
  final phoneNumber = "".obs;
  final networkOperator = "".obs;
  final deviceIMEI = "".obs;
  final simSerialNumber = "".obs;
  final simState = "".obs;
  final isInCall = ''.obs;
  final isVoiceCapable = ''.obs;
  final isNetworkRoaming = ''.obs;
  final phoneType = ''.obs;
  final deviceId = ''.obs;
  final subscriberId = ''.obs;
  final isFetching = true.obs;
  final hasError = false.obs;
  // ignore: unnecessary_overrides
  @override
  void onInit() {
    super.onInit();
    getValuesFromDefaultSim();
  }

  Future<void> getValuesFromDefaultSim() async {
    isFetching.value = true;
    hasError.value = false;
    try {
      final info = await const TelephonyRepository().getInfo();
      isFetching.value = false;
      if (info.containsKey('Error')) {
        hasError.value = true;
      } else {
        phoneNumber.value = info["phoneNumber"] ?? '';
        networkOperator.value = info["networkOperator"] ?? '';
        deviceIMEI.value = info["deviceIMEI"] ?? '';
        simSerialNumber.value = info["simSerialNumber"] ?? '';
        simState.value = info["simState"] ?? '';
        isInCall.value = info["isInCall"] ?? '';
        isVoiceCapable.value = info["isVoiceCapable"] ?? '';
        isNetworkRoaming.value = info["isNetworkRoaming"] ?? '';
        phoneType.value = info["phoneType"] ?? '';
        deviceId.value = info["deviceId"] ?? ' ';
        subscriberId.value = info["subscriberId"] ?? '';
      }
      return;
    } catch (e) {
      isFetching.value = false;
      hasError.value = true;
    }
  }
}
