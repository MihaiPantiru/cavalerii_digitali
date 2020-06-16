import Foundation
import Vapor
import Fluent

final class RegisterController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let registerRoute = routes.grouped("api", "register")
        registerRoute.post(use: createHandle)
        registerRoute.get(use: getAllHandler)
        registerRoute.delete(":userID", use: deleteHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[Student]> {
        return Student.query(on: req.db).all()
    }
    
    func createHandle(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let student = try req.content.decode(Student.self)
        return student.create(on: req.db).transform(to: HTTPStatus.ok)
    }
    
    func deleteHandler(_ req: Request)
        throws -> EventLoopFuture<HTTPStatus> {
            let itemToDelete = Student.find(req.parameters.get("userID"), on: req.db)
                .unwrap(or: Abort(.notFound))
            let status = itemToDelete.flatMap { item -> EventLoopFuture<Void> in
                return item.delete(on: req.db)
            }
            
            return status.transform(to: HTTPStatus.ok)
    }
}
