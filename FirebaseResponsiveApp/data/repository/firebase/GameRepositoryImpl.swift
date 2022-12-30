//
//  GameRepositoryImpl.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 20/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class GameRepositoryImpl : GameRepository {

    var db = Firestore.firestore()    
    

    func getGames(platform: String) async throws ->  [GameModel] {
        var gamesList : [GameModel] = []
        
        do{
            let documents = try await db.collection(platform).getDocuments().documents
            for document in documents{
               
                let data = document.data()
                let id = document.documentID
                let tittle = data["titulo"] as? String ?? "Sin titulo"
                let desc = data["desc"] as? String ?? "Sin descripcion"
                let portada = data["portada"] as? String ?? "Sin portada"

                let game = GameModel(id: id, titulo: tittle, desc: desc, portada: portada)
        
                gamesList.append(game)
            }
            
            print("Desde API")
            print(gamesList)
            return gamesList
        }catch{
            print(error.localizedDescription)
            throw NSError()
            
        }

    }
    
    func save(titulo: String, desc: String, platform: String, directorioUrl: String) async throws{
    
        do{
            let id = UUID().uuidString
            guard let userId = Auth.auth().currentUser?.uid else { return }
            
            let data : [String: Any] = ["userId": userId, "titulo": titulo, "desc": desc, "portada": directorioUrl]
            
            try await db.collection(platform).document(id).setData(data)
        
        }catch{
            print(error.localizedDescription)
            throw NSError()
        }
        
    
    }
    
    func update(platform: String, id: String, data: [String: Any]) async throws{
        do{
            try await db.collection(platform).document(id).updateData(data)
        }catch{
            print(error.localizedDescription)
            throw NSError()
        }
        
    }
    
    func delete(game: GameModel, platform: String) async throws{
        do{
            try await db.collection(platform).document(game.id).delete()
            print("deleted item")
        }catch{
            print(error.localizedDescription)
            throw NSError()
            
        }
     
    }
    
    
}
