import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // MARK: - Dummy examples
    
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    // MARK: - Form
    
    let formController = FormController()
    try app.register(collection: formController)
    
    // MARK: - Register
    
    let registerController = RegisterController()
    try app.register(collection: registerController)
}
