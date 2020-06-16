import Foundation
import Vapor
import Fluent

final class FormController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let formRoute = routes.grouped("api", "form")
        formRoute.post(use: createHandle)
        formRoute.get(use: getAllHandler)
        formRoute.delete(":formID", use: deleteHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[FormResult]> {
        return FormResult.query(on: req.db).all()
    }
    
    func createHandle(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let formResult = try req.content.decode(FormResult.self)
        return formResult.create(on: req.db).transform(to: HTTPStatus.ok)
    }
    
    func deleteHandler(_ req: Request)
        throws -> EventLoopFuture<HTTPStatus> {
            let itemToDelete = FormResult.find(req.parameters.get("formID"), on: req.db)
                .unwrap(or: Abort(.notFound))
            let status = itemToDelete.flatMap { item -> EventLoopFuture<Void> in
                return item.delete(on: req.db)
            }
            
            return status.transform(to: HTTPStatus.ok)
    }
}
