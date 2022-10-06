//
//  ServerStatusCache.swift
//  
//
//  Created by Nathan Fallet on 06/10/2022.
//

import Vapor

class ServerStatusCache {
    
    private static var lastCacheUpdate = Date().timeIntervalSince1970
    private static var statuses: [ServerStatus]?
    
    private static func updateCacheIfNeeded(in request: Request) async throws {
        let now = Date().timeIntervalSince1970
        if (now - lastCacheUpdate >= 300 || statuses == nil) {
            // Get server status
            statuses = try await [
                ("Mini jeux", "minigames.ensilan.fr"),
                ("Cité des émeraudes", "city.ensilan.fr"),
                ("Survie", "survival.ensilan.fr")
            ].asyncMap { name, ip in
                let response = try await request.client
                    .get("https://api.mcsrvstat.us/2/\(ip)")
                var status = try response.content.decode(ServerStatus.self)
                status.name = name
                return status
            }
            
            // Update date
            lastCacheUpdate = now
        }
    }
    
    static func getStatuses(in request: Request) async throws -> [ServerStatus] {
        try await updateCacheIfNeeded(in: request)
        return statuses ?? []
    }
    
}
