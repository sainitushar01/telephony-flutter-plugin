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
                      child: (controller.platform == "ios")
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    'Carrier Name: ${controller.carrierName.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Device Model: ${controller.deviceModel.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Iso country code: ${controller.isoCountryCode.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Mobile Country Code: ${controller.mobileCountryCode.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Network Code: ${controller.mobileNetworkCode.value}'),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    'Sim Card Number:${controller.number.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Carrier Name: ${controller.carrierName.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Sim State: ${controller.simState.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Phone type: ${controller.phoneType.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Sim Slot Count: ${controller.simSlotCount.value}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Subscription Id For Slot: ${controller.subscriptionIdForSlot.value}'),
                              ],
                            ),
                    );
        },
      ),
    );
  }
}
/*
deviceModel"]!;
o["isoCountryCode"]!;
info["mobileCountryCode"
info["mobileNetworkCode"
*/