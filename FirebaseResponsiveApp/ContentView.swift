//
//  ContentView.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 17/12/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginState : FirebaseAuthViewModel
    
    var body: some View {
        return Group{
            if loginState.isAuthenticated{
                Home()
                    .edgesIgnoringSafeArea(.all)
            }else{
                Login()
            }
        }.onAppear{
            if (UserDefaults.standard.object(forKey: "session") != nil){
                loginState.isAuthenticated = true
            }
        }
  
    }
}

