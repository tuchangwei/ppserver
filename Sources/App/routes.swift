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
            Art(url: baseURL + "1.png", isNew: true, isLocked: false),
            Art(url: baseURL + "2.png", isNew: false, isLocked: true),
            Art(url: baseURL + "3.png", isNew: false, isLocked: false),
            Art(url: baseURL + "4.png", isNew: false, isLocked: false),
            Art(url: baseURL + "5.png", isNew: false, isLocked: false),
            Art(url: baseURL + "6.png", isNew: false, isLocked: false),
            Art(url: baseURL + "7.png", isNew: false, isLocked: false),
            Art(url: baseURL + "8.png", isNew: false, isLocked: false),
            Art(url: baseURL + "9.png", isNew: false, isLocked: false),
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
