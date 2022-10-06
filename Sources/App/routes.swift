import Fluent
import Vapor

func apiRoutes(_ app: Application) throws {
    
}

func routes(_ app: RoutesBuilder) throws {
    app.get("", use: HomeController.get)
}
