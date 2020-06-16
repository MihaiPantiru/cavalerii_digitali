import Foundation
import Fluent

struct CreatFormResults: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(FormResult.schema)
            .id()
            .field(.name, .string, .required)
            .field(.address, .string, .required)
            .field(.birthDate, .string, .required)
            .field(.outOfCountry, .bool, .required)
            .field(.hasSymptoms, .bool, .required)
            .field(.symptoms, .array(of: .string), .required)
            .field(.createdAt, .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(FormResult.schema).delete()
    }
}
