import Core
import HTTP
import Routing
import Vapor

extension AsyncController {
    @discardableResult
    public func on<Input, Output: Codable>(_ method: HTTP.Method, input: Input.Type, to path: PathComponentRepresentable..., use closure: @escaping (TypeSafeRequest<Input>) throws -> Future<Output>) -> Route {
        let responder = BasicAsyncResponder { (request: Request) -> Future<Response> in
            let typeSafeRequest = try TypeSafeRequest<Input>(request: request, for: self.container)
            
            return try closure(typeSafeRequest).map { output in
                let response = TypeSafeResponse(body: output)
            
                return try response.makeResponse(for: request, for: self.container)
            }
        }
        
        let route = Route(method: method, path: path.makePathComponents(), responder: responder)
        routes.append(route)
        return route
    }
    
    @discardableResult
    public func on<Output>(_ method: HTTP.Method, to path: PathComponentRepresentable..., use closure: @escaping (Request) throws -> Future<TypeSafeResponse<Output>>) -> Route {
        let responder = BasicAsyncResponder { (request: Request) -> Future<Response> in
            return try closure(request).map { output in
                return try output.makeResponse(for: request, for: self.container)
            }
        }
        
        let route = Route(method: method, path: path.makePathComponents(), responder: responder)
        routes.append(route)
        return route
    }
    
    @discardableResult
    public func on<Output: Codable>(_ method: HTTP.Method, to path: PathComponentRepresentable..., use closure: @escaping (Request) throws -> Future<Output>) -> Route {
        let responder = BasicAsyncResponder { (request: Request) -> Future<Response> in
            return try closure(request).map { output in
                let response = TypeSafeResponse(body: output)
                
                return try response.makeResponse(for: request, for: self.container)
            }
        }
        
        let route = Route(method: method, path: path.makePathComponents(), responder: responder)
        routes.append(route)
        return route
    }
}
