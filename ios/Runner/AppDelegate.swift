import UIKit
import Flutter
import GoogleMaps
import TMapSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, TMapTapiDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(Storage().googleMapApiKey)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name : "mobile/parameters", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler({
      [weak self] (call : FlutterMethodCall, result : FlutterResult) -> Void in

      switch (call.method) {
      case "initTmapAPI":
          self?.initTmapAPI()
          result("initTmapAPI")
          break;

      case "isTmapApplicationInstalled":
          if(TMapApi.isTmapApplicationInstalled()){
            result("")
          }else{
            let url = TMapApi.getTMapDownUrl()
            result(url)
          }
          break;
        
      default:
        result(FlutterMethodNotImplemented)
        break;
      }
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func initTmapAPI(){
        TMapApi.setSKTMapAuthenticationWithDelegate(self, apiKey: Storage().tMapApiKey)
    }
}
