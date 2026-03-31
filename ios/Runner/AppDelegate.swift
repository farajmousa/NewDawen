import UIKit
import Flutter
import Firebase  // Add this import

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Initialize Firebase
        FirebaseApp.configure()

    GeneratedPluginRegistrant.register(with: self)
    application.registerForRemoteNotifications()  //* I Forgot This Line *
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Handle APNS token registration
    override func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      // Pass the APNS token to Firebase Messaging
      Messaging.messaging().apnsToken = deviceToken
      super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}
