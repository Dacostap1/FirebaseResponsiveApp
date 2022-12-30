//
//  Login.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 18/12/22.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focus : Bool

    @EnvironmentObject var loginState : FirebaseAuthViewModel
    
    //Para agregar un frame solo al ipad y que no ocupe todo el ancho
    var device = UIDevice.current.userInterfaceIdiom
    
    
    init() {
        _email = State(initialValue: "d4ni3L_15@hotmail.com")
        _password = State(initialValue: "123456")
    }
    
    
    var body: some View {
        ZStack{
            Color.purple.edgesIgnoringSafeArea(.all)
            VStack{
                Text("My Games")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .frame(width: device == .pad ? 400 : nil)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: device == .pad ? 400 : nil)
                    .padding(.bottom, 20)
                    .submitLabel(.send)
                    .focused($focus)
                
                Button(action: {
                    focus = false
                    loginState.login(email: email, password: password) { done in
                        if done {
                            //Puede ir en el ViewModel pero es para explicar el done
                          
                            UserDefaults.standard.set(true, forKey: "session") 
                            loginState.isAuthenticated = true
                    
                        }
                    }
                }){
                    Text("Entrar")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(width: 200)
                }.background(
                    Capsule().stroke(.white)
                )
                Divider()
                Button(action: {
                    loginState.register(email: email, password: password) { done in
                        if done {
                            //Puede ir en el ViewModel pero es para explicar el done
                            UserDefaults.standard.set(true, forKey: "session")
                            loginState.isAuthenticated = true
                        }
                    }
                }){
                    Text("Registrate")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(width: 200)
                }.background(
                    Capsule().stroke(.white)
                )
            }.padding()
        }
    }
}


