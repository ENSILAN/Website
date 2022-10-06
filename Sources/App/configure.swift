import Fluent
import FluentMySQLDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // Get port
    app.http.server.configuration.port = Int(Environment.get("PORT") ?? "8080") ?? 8080
    
    // Database
    var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
    tlsConfiguration.certificateVerification = .none
    app.databases.use(.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "127.0.0.1",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "root",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "minecraft",
        tlsConfiguration: tlsConfiguration
    ), as: .mysql)
    app.sessions.use(.fluent)
    
    // Middlewares
    app.middleware.use(FileMiddleware(
        publicDirectory: app.directory.publicDirectory
    ))
    
    // Register Leaf and Lingo
    app.views.use(.leaf)
    
    // Register routes
    app.routes.defaultMaxBodySize = "128kb"
    try apiRoutes(app)
    try routes(app
        .grouped(app.sessions.middleware)
    )
}
