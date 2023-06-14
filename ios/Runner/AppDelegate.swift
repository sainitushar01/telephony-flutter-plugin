import UIKit
import Flutter
import CoreTelephony
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController=window?.rootViewController as! FlutterViewController
    let deviceChannel=FlutterMethodChannel(name:"sim.flutter.methodchannel/ios",binaryMessenger:controller.binaryMessenger)
    prepareMethodHandler(deviceChannel: deviceChannel)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
       let networkInfo = CTTelephonyNetworkInfo()
       if let carrier = networkInfo.subscriberCellularProvider {

        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getDeviceModel" {
                self.receiveDeviceModel(result: result)
            }
            else if call.method=="getCarrierName"{
              let carrierName = carrier.carrierName ?? "Unknown"
              result(carrierName)
            }
            else if call.method=="getMobileCountryCode"{
              let mobileCountryCode = carrier.mobileCountryCode ?? "Unknown"
              result(mobileCountryCode)
            }
            else if call.method== "getMobileNetworkCode"{
              let mobileNetworkCode = carrier.mobileNetworkCode ?? "Unknown"
              result(mobileNetworkCode)
            }
             else if call.method== "getIsoCountryCode"{
              let isoCountryCode = carrier.isoCountryCode ?? "Unknown"
              result(isoCountryCode)
             }
            else {
                result(FlutterMethodNotImplemented)
            }   
            return
        }
        )
    }
      else{
    print("SIM info not available")
  }
    }
        private func receiveDeviceModel(result: FlutterResult) {
        let deviceModel = UIDevice.current.model
        result(deviceModel)
    }
}
