public final class Website: Codable {
    var name: String
    var domains: [String]
    
    // Site for domains
}

open class Page: Codable {
    var title: String
    
    init(named name: String) {
        self.title = name
    }
}
