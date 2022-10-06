import Vapor

class HomeController {
    
    static func get(_ request: Request) async throws -> View {
        // Create context
        let homeContext = HomeContext(
            description: "",
            players: try await LeaderboardCache.getPlayers(in: request),
            statuses: try await ServerStatusCache.getStatuses(in: request)
        )
        
        return try await request.view.render("home", homeContext)
    }
    
}

struct HomeContext: Codable {
    
    var description: String
    var players: [HomePlayersSection]
    var statuses: [ServerStatus]
    
}

struct HomePlayersSection: Codable {
    
    var id: String
    var name: String
    var players: [LeaderboardPlayer]
    
}
