//
//  Model.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 19/12/22.
//

import Foundation

struct GameModel : Identifiable, Equatable {
    var id: String
    var titulo: String
    var desc: String
    var portada: String
    
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.titulo == rhs.titulo &&
        lhs.desc == rhs.desc &&
        lhs.portada == rhs.portada
    }
}
    
