//
//  ButtonComponent.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 17/12/22.
//

import SwiftUI

struct ButtonComponent: View {
    @Binding var index : String
    @Binding var showMenu : Bool
    let title : String
    
    //Detecta dispositivo actual
    var device = UIDevice.current.userInterfaceIdiom
    
    
    var body: some View {
        Button(action: {
            withAnimation {
                if device == .phone {
                    showMenu.toggle()
                }
                
                index = title
            }
        }) {
            Text(title)
                .font(.title)
                .fontWeight(index == title ? .bold : .none)
                .foregroundColor(index == title ? .white : Color.white.opacity(0.6))
        }
    }
}

