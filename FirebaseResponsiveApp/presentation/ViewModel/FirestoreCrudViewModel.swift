//
//  FirebaseCrudViewModel.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 18/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


@MainActor
class FirestoreCrudViewModel: ObservableObject {
    @Published var gamesList = [GameModel]()
    
    private var gameRepository = GameRepositoryImpl()
    private var storageRepository = StorageRepositoryImpl()
    
    var db = Firestore.firestore()
    

    func getGames(platform: String) async {
        gamesList =  try! await gameRepository.getGames(platform: platform)
    }
    

    func saveAsync(titulo: String, desc: String, platform: String, portada: Data) async throws{
        
        do{
            let res = try await storageRepository.save(image: portada)
            try await gameRepository.save(titulo: titulo, desc: desc, platform: platform, directorioUrl: res)
        }catch{
            print(error)
        }
    }
    
    func save(titulo: String, desc: String, platform: String, portada: Data, completion: @escaping (_ done: Bool)-> Void){
        //Function with completation callbacks
        //SAVE STORAGE
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorio = storage.child("imagenes/\(nombrePortada)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(portada, metadata: metadata){data, error in
            
        
            if let error = error?.localizedDescription{
                return print(error)
            }
            
            if(error != nil){
                return print("fallo la app")
            }
            
            //SAVE DOCUMENT
            let id = UUID().uuidString
            guard let userId = Auth.auth().currentUser?.uid else { return }
    
            let data : [String: Any] = ["userId": userId, "titulo": titulo, "desc": desc, "portada": String (describing: directorio)]
            self.db.collection(platform).document(id).setData(data){error in
                if let error = error?.localizedDescription{
                    print(error)
                }else{
                    print("save")
                    completion(true)
                }
            }
        }
    }
    
    func update(titulo: String, desc: String, portada: Data?, game: GameModel, platform: String) async throws {
        
        do {
            if let portada = portada {
                print("save with portada")
                try await storageRepository.delete(portada: game.portada)
                let gsUrl = try await storageRepository.save(image: portada)
                
                let data : [String : Any] = ["titulo": titulo, "desc": desc, "portada": gsUrl]
                try await gameRepository.update(platform: platform, id: game.id, data: data)
    
            }else{
                print("save without portada")
                let data : [String : Any] = ["titulo": titulo, "desc": desc]
                try await gameRepository.update(platform: platform, id: game.id, data: data)
            }
            
        }catch{
            print(error)
        }
       
    
        print("reload data")
        self.gamesList = try await gameRepository.getGames(platform: platform)
        print("reload final")
        
    }
    

    func delete(game: GameModel, platform: String) async throws{
        do{
            try await gameRepository.delete(game: game, platform: platform)
            try await storageRepository.delete(portada: game.portada)
            
            self.gamesList.removeAll { item in
                item.id == game.id
            }
        }
        catch{
            print(error)
        }

    }
}
