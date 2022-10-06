import Fluent
import Vapor

final class Player: Model, Content {
    
    static let schema = "players"
    
    @ID(custom: "uuid")
    var id: String?

    @Field(key: "name")
    var name: String
    
    @Field(key: "money")
    var money: Int64
    
    @Field(key: "score")
    var score: Int64
    
    @Field(key: "victories")
    var victories: Int64

    init() { }
    
    func toLeaderboardPlayer() -> LeaderboardPlayer {
        return LeaderboardPlayer(
            name: name,
            value: victories,
            label: "victoires"
        )
    }
    
}
