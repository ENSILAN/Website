import Fluent
import Vapor

final class CityPlayer: Model, Content {
    
    static let schema = "city_players"
    
    @ID(custom: "uuid")
    var id: String?

    @Parent(key: "uuid")
    var player: Player
    
    @Field(key: "emeralds")
    var emeralds: Int64

    init() { }
    
    func toLeaderboardPlayer() -> LeaderboardPlayer {
        return LeaderboardPlayer(
            name: player.name,
            value: emeralds,
            label: "émeraudes"
        )
    }
    
}
