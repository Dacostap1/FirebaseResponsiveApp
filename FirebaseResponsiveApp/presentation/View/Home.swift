//
//  Home.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 17/12/22.
//

import SwiftUI

struct Home: View {
    @State private var index = "PlayStation"
    @State private var showMenu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    
    @EnvironmentObject var loginState : FirebaseAuthViewModel
    
    var body: some View {
        ZStack {
            VStack{
                NavBarComponent(index: $index, showMenu: $showMenu)
                ZStack{
                    if (index == "PlayStation") {
                        ListView(platform: "playstation")
                    }else if (index == "Xbox") {
                        ListView(platform: "xbox")
                    }
                    else if (index == "Nintendo")  {
                        ListView(platform: "nintendo")
                    }else {
                        AddItem()
                    }
                }
            }
            
            //ONLY IPHONE
            if showMenu {
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }){
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding().padding(.top, 50)
                        
                        
                        Text("Menu")
                            .font(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                            .frame(width: .infinity, alignment: .trailing)
                            
                        VStack(alignment: .trailing){
                            ButtonComponent(index: $index, showMenu: $showMenu, title: "PlayStation")
                            ButtonComponent(index: $index, showMenu: $showMenu, title: "Xbox")
                            ButtonComponent(index: $index, showMenu: $showMenu, title: "Nintendo")
                         
                            Button(action: {
                                loginState.logout()
                            }) {
                                Text("Salir")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 150)
                    .background(Color.purple)
                }
            }
        }.background(Color("fondo")) //Agregado en Assets
    }
}




