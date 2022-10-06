//
//  ServerStatus.swift
//  
//
//  Created by Nathan Fallet on 06/10/2022.
//

import Foundation

struct ServerStatus: Codable {
    
    var online: Bool
    var motd: ServerStatusMOTD
    
}

struct ServerStatusMOTD: Codable {
    
    var html: [String]
    
}
