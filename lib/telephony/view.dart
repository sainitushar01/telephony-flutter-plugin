import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephony/error.dart';
import 'package:telephony/telephony/view_controller.dart';

class View extends GetView<ViewController> {
  const View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return (controller.isFetching.value)
              ? const Center(child: CircularProgressIndicator())
              : controller.hasError.value
                  ? const ShowErrorScreen()
                  : Center(
                      child: Column(
                        children: <Widget>[
                          Text('phoneNumber: ${controller.phoneNumber.value}'),
                          const SizedBox(height: 10),
                          Text(
                              'networkOperator: ${controller.networkOperator.value}'),
                          const SizedBox(height: 10),
                          Text('deviceIMEI: ${controller.deviceIMEI.value}'),
                          const SizedBox(height: 10),
                          Text(
                              'simSerialNumber: ${controller.simSerialNumber.value}'),
                          const SizedBox(height: 10),
                          Text('simState: ${controller.simState.value}'),
                          const SizedBox(height: 10),
                          Text('isInCall: ${controller.isInCall.value}'),
                          const SizedBox(height: 10),
                          Text(
                              'isVoiceCapable: ${controller.isVoiceCapable.value}'),
                          const SizedBox(height: 10),
                          Text('deviceId: ${controller.deviceId.value}'),
                          const SizedBox(height: 10),
                          Text(
                              'isNetworkRoaming: ${controller.isNetworkRoaming.value}'),
                          const SizedBox(height: 10),
                          Text(
                              'subscriberId: ${controller.subscriberId.value}'),
                          const SizedBox(height: 10),
                          Text('phoneType: ${controller.phoneType.value}'),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
