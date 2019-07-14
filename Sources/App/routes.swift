import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("arts") { req -> [Art] in
        let baseURL = "http://\(NIOServerConfig.default().hostname):\(NIOServerConfig.default().port)/"
        return [
            Art(url: baseURL + "diamond.png"),
            Art(url: baseURL + "flame.png"),
            Art(url: baseURL + "girl.png"),
            Art(url: baseURL + "heart.png"),
            Art(url: baseURL + "marked_man.png"),
            Art(url: baseURL + "rocket.png"),
            Art(url: baseURL + "sword.png"),
            Art(url: baseURL + "toy.png"),
        ]
    }
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
struct Art: Content {
    var url: String
}
