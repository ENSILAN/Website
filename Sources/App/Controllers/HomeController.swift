import Vapor

class HomeController {
    
    static func get(_ request: Request) async throws -> View {
        // Create context
        let homeContext = HomeContext(
            description: "Rejoins la compétition en jeu sur notre serveur Minecraft, et amuse toi avec nos différents mini jeux et la cité des émeraudes !",
            players: try await LeaderboardCache.getPlayers(in: request),
            statuses: try await ServerStatusCache.getStatuses(in: request)
        )
        
        return try await request.view.render("home", homeContext)
    }
    
}

struct HomeContext: Codable {
    
    var description: String
    var players: [Leaderboard]
    var statuses: [ServerStatus]
    
}
