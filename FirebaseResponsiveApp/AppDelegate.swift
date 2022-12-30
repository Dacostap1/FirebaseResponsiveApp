//
//  AppDelegate.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 18/12/22.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
