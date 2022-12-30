//
//  GameRepository.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 20/12/22.
//

import Foundation

protocol GameRepository {
    func getGames(platform : String) async throws ->   [GameModel]
    //func getGamesSpanshot(platform : String) -> Void //Para mas adelante aprender a usarlo con snapshots
    func save(titulo: String, desc: String, platform: String, directorioUrl: String) async throws -> Void
    func update(platform: String, id: String, data: [String: Any]) async throws -> Void
    func delete(game: GameModel, platform : String) async throws -> Void
}
