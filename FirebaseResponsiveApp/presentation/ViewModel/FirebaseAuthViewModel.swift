//
//  FirebaseViewModel.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 18/12/22.
//

import Foundation
import Firebase

class FirebaseAuthViewModel : ObservableObject {
    @Published var isAuthenticated = false
    
    func login(email: String, password: String, completion: @escaping(_ done: Bool)-> Void){
        Auth.auth().signIn(withEmail: email, password: password){
            (user, error) in
            if user != nil {
                print("login")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print(error)
                }else{
                    print("otro error de la app")
                }
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping(_ done: Bool)-> Void){
        Auth.auth().createUser(withEmail: email, password: password){
            (user, error) in
            if user != nil {
                print("register")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print(error)
                }else{
                    print("otro error de la app")
                }
            }
        }
    }
    
    func logout(){
        try! Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "session") //AppStorage("session") var session : String = ""
        isAuthenticated = false
        print("logout")
    }
}
