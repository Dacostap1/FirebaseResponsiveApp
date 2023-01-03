//
//  StorageRepositoryImpl.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 20/12/22.
//

import Foundation
import FirebaseStorage

class StorageRepositoryImpl : StorageRepository{

    func save(image: Data) async throws -> String {
        do{
            let storage = Storage.storage().reference()
            let nombrePortada = UUID()
            let directorio = storage.child("images/\(nombrePortada)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            let res = try await directorio.putDataAsync(image, metadata: metadata)
            let url = try await directorio.downloadURL() //  String (describing: directorio)
            return url.absoluteString
        }catch{
            print(error.localizedDescription)
            throw NSError()
        }
      
    }
    
    func delete(portada: String) async throws {
        do{
            try await Storage.storage().reference(forURL: portada).delete()
            print("deleted image")
        }catch{
            print(error.localizedDescription)
            throw NSError()
        }
   
    }
}
