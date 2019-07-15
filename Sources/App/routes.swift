import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("arts") { req -> [Art] in
        print(req.http.headers)
        let proto = req.http.headers.firstValue(name: HTTPHeaderName("X-Forwarded-Proto"))
            ?? req.http.url.scheme
            ?? "http"
        guard let host = req.http.headers.firstValue(name: .host) else {
            throw Abort(.badRequest)
        }
        let baseURL = "\(proto)://\(host)/"
        return [
            Art(url: baseURL + "diamond.png", isNew: true, isLocked: false),
            Art(url: baseURL + "flame.png", isNew: false, isLocked: true),
            Art(url: baseURL + "girl.png", isNew: false, isLocked: false),
            Art(url: baseURL + "heart.png", isNew: false, isLocked: false),
            Art(url: baseURL + "marked_man.png", isNew: false, isLocked: false),
            Art(url: baseURL + "rocket.png", isNew: false, isLocked: false),
            Art(url: baseURL + "sword.png", isNew: false, isLocked: false),
            Art(url: baseURL + "toy.png", isNew: false, isLocked: false),
        ]
    }
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
struct Art: Content {
    let url: String
    let isNew: Bool
    let isLocked: Bool
}
