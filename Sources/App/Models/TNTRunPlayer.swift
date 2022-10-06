import Fluent
import Vapor

final class TNTRunPlayer: Model, Content {
    
    static let schema = "tntrun_players"
    
    @ID(custom: "uuid")
    var id: String?

    @Parent(key: "uuid")
    var player: Player
    
    @Field(key: "score")
    var score: Int64
    
    @Field(key: "victories")
    var victories: Int64

    init() { }
    
    func toLeaderboardPlayer() -> LeaderboardPlayer {
        return LeaderboardPlayer(
            name: player.name,
            value: victories,
            label: "victoires"
        )
    }
    
}
