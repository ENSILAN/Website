import Vapor

class MinigamesController {
    
    static func get(_ request: Request) async throws -> View {
        // Create context
        let mgContext = MinigamesContext(
            title: "Mini jeux",
            description: "Informations sur les mini jeux proposés par l'ENSILAN",
            players: try await LeaderboardCache.getPlayers(in: request).filter{ $0.id.contains("victories") },
            statuses: try await ServerStatusCache.getStatuses(in: request).filter{ $0.name?.contains("Mini jeux") ?? false }
        )
        
        return try await request.view.render("minigames", mgContext)
    }
    
}

struct MinigamesContext: Codable {
    
    var title: String
    var description: String
    var players: [Leaderboard]
    var statuses: [ServerStatus]
    
}
