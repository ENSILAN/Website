//
//  ServerStatus.swift
//  
//
//  Created by Nathan Fallet on 06/10/2022.
//

import Foundation

struct ServerStatus: Codable {
    
    var name: String?
    
    var online: Bool
    var motd: ServerStatusMOTD?
    var players: ServerStatusPlayers?
    
}

struct ServerStatusMOTD: Codable {
    
    var html: [String]
    
}

struct ServerStatusPlayers: Codable {
    
    var online: Int
    var max: Int
    
}
