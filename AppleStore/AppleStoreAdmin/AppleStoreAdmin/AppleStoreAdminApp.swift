//
//  AppleStoreAdminApp.swift
//  AppleStoreAdmin
//
//  Created by cha_nyeong on 2023/09/05.
//

import SwiftUI
import FirebaseCore

let DeviceWidth = UIScreen.main.bounds.size.width
let DeviceHeight = UIScreen.main.bounds.size.height


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct AppleStoreAdminApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        UITextField.appearance().tintColor = .gray  //TextField 커서 색상 변경
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartView()
            }
        }
    }
}
