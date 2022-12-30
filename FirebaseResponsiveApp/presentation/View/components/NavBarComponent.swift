//
//  NavBarComponent.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 17/12/22.
//

import SwiftUI

struct NavBarComponent: View {
    @Binding var index : String
    @Binding var showMenu : Bool
    
    //Detecta dispositivo actual
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        HStack{
            Text("My Games")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                MenuIpad(index: $index, showMenu: $showMenu)
            }else{
                MenuIphone(index: $index, showMenu: $showMenu)
            }
        }
        .padding(.top, 30)
        .padding()
        .background(Color.purple)
            
    }
}

struct MenuIpad: View {
    @Binding var index : String
    @Binding var showMenu : Bool
    
    @EnvironmentObject var loginState : FirebaseAuthViewModel
    
    var body: some View {
        HStack(spacing: 25){
            ButtonComponent(index: $index, showMenu: $showMenu, title: "PlayStation")
            ButtonComponent(index: $index, showMenu: $showMenu, title: "Xbox")
            ButtonComponent(index: $index, showMenu: $showMenu, title: "Nintendo")
            ButtonComponent(index: $index, showMenu: $showMenu, title: "Agregar")
            Button(action: {
                loginState.logout()
            }) {
                Text("Salir")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .padding(.horizontal, 10)
            }.background(
                Capsule().stroke(.white)
            )
        }
    }
}

struct MenuIphone: View {
    @Binding var index : String
    @Binding var showMenu : Bool
    
    var body: some View {
        HStack(spacing: 25){
            Button(action: {
                index = "Agregar"
            }){
                Image(systemName: "plus")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
            }
            Button(action: {
                withAnimation {
                    showMenu.toggle()
                }
            }){
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
            }
        }
    }
}
