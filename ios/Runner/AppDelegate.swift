import UIKit
import Flutter

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
        
        // 4
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            // 5
            if call.method == "getDeviceModel" {
                
                // 6
                self.receiveDeviceModel(result: result)
            }
            else {
                // 9
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
        private func receiveDeviceModel(result: FlutterResult) {
        // 7
        let deviceModel = UIDevice.current.model
        
        // 8
        result(deviceModel)
    }
}
