//
//  StorageRepository.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 20/12/22.
//

import Foundation

protocol StorageRepository {
    
    func save(image : Data) async throws -> String
    func delete(portada : String) async throws  -> Void
}
