//
//  FirebaseResponsiveAppApp.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 17/12/22.
//

import SwiftUI

@main
struct FirebaseResponsiveAppApp: App {
    
    //CREADO MANUALMENTE
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        let login = FirebaseAuthViewModel()
        
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
