//
//  LeaderboardPlayer.swift
//  
//
//  Created by Nathan Fallet on 05/10/2022.
//

import Vapor

struct LeaderboardPlayer: Codable {
    
    var name: String
    var value: Int64
    var label: String
    
}
