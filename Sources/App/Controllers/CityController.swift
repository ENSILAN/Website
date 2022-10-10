import Vapor

class CityController {
    
    static func get(_ request: Request) async throws -> View {
        // Create context
        let cityContext = CityContext(
            title: "Cité des émeraudes",
            description: "Le guide pour participer à la cité des émeraudes à l'ENSILAN",
            leaderboard: try await LeaderboardCache.getPlayers(in: request).first(where: { $0.name.contains("Cité") }),
            statuses: try await ServerStatusCache.getStatuses(in: request).filter { $0.name?.contains("Cité") ?? false }
        )
        
        return try await request.view.render("city", cityContext)
    }
    
}

struct CityContext: Codable {
    
    var title: String
    var description: String
    var leaderboard: Leaderboard?
    var statuses: [ServerStatus]
    
}
