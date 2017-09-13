import Core
import HTTP
import Routing
import Vapor

public final class WebsiteController: RouteCollection {
    let controller: AsyncController<Application>
    
    public init(application: Application) {
        self.controller = AsyncController(for: application)
        
        self.controller.on(.post, input: CreateWebsite.Input.self, to: "websites") { request in
            return Future(CreateWebsite.Success())
        }
        
        self.controller.on(.get, to: "sites") { request in
            return Future(Websites())
        }
    }
    
    public func register(to router: Router) {
        controller.register(to: router)
    }
}

struct CreateWebsite {
    struct Input: Codable {
        var name: String
        var domains: [String]
    }
    
    struct Success: Codable {
        
    }
}

struct Websites: Codable {
    
}
