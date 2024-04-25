//
//  ReportItApp.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
}

@main
struct ReportItApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var opendURL = false

    var body: some Scene {
        WindowGroup {
            ContentView(opendURL: $opendURL)
                .onOpenURL { _ in
                    opendURL = true
                    print(opendURL)
                }
        }
    }
}
