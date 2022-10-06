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
                "minigames.ensilan.fr",
                "city.ensilan.fr",
                "survival.ensilan.fr"
            ].asyncMap { ip in
                let response = try await request.client
                    .get("https://api.mcsrvstat.us/2/\(ip)")
                return try response.content.decode(ServerStatus.self)
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
