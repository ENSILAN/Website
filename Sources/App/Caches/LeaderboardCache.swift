//
//  LeaderboardCache.swift
//  
//
//  Created by Nathan Fallet on 06/10/2022.
//

import Vapor

class LeaderboardCache {
    
    private static var lastCacheUpdate = Date().timeIntervalSince1970
    private static var players: [Leaderboard]?
    
    private static func updateCacheIfNeeded(in request: Request) async throws {
        let now = Date().timeIntervalSince1970
        if (now - lastCacheUpdate >= 30 || players == nil) {
            // Get data for leaderboard
            let players = try await Player.query(on: request.db)
                .sort(\.$victories, .descending)
                .limit(10)
                .all()
                .map{ $0.toLeaderboardPlayer() }
                .filter{ $0.value > 0 }
            let cityPlayers = try await CityPlayer.query(on: request.db)
                .with(\.$player)
                .sort(\.$emeralds, .descending)
                .limit(10)
                .all()
                .map{ $0.toLeaderboardPlayer() }
                .filter{ $0.value > 0 }
            let replicaPlayers = try await ReplicaPlayer.query(on: request.db)
                .with(\.$player)
                .sort(\.$victories, .descending)
                .limit(10)
                .all()
                .map{ $0.toLeaderboardPlayer() }
                .filter{ $0.value > 0 }
            let tntrunPlayers = try await TNTRunPlayer.query(on: request.db)
                .with(\.$player)
                .sort(\.$victories, .descending)
                .limit(10)
                .all()
                .map{ $0.toLeaderboardPlayer() }
                .filter{ $0.value > 0 }
            let dacPlayers = try await DACPlayer.query(on: request.db)
                .with(\.$player)
                .sort(\.$victories, .descending)
                .limit(10)
                .all()
                .map{ $0.toLeaderboardPlayer() }
                .filter{ $0.value > 0 }
            self.players = [
                Leaderboard(id: "victories", name: "Victoires", players: players),
                Leaderboard(id: "city", name: "Cité des émeraudes", players: cityPlayers),
                Leaderboard(id: "victories_replica", name: "Replica", players: replicaPlayers),
                Leaderboard(id: "victories_tntrun", name: "TNT Run", players: tntrunPlayers),
                Leaderboard(id: "victories_deacoudre", name: "Dé à coudre", players: dacPlayers)
            ]
            
            // Update date
            lastCacheUpdate = now
        }
    }
    
    static func getPlayers(in request: Request) async throws -> [Leaderboard] {
        try await updateCacheIfNeeded(in: request)
        return players ?? []
    }
    
}

struct Leaderboard: Codable {
    
    var id: String
    var name: String
    var players: [LeaderboardPlayer]
    
}
