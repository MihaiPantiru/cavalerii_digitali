import Foundation
import Fluent

struct CreatStudents: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Student.schema)
            .id()
            .field(.name, .string, .required)
            .field(.className, .string, .required)
            .field(.device, .string, .required)
            .field(.reason, .string, .required)
            .field(.createdAt, .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Student.schema).delete()
    }
}
