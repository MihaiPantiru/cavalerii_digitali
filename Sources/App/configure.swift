import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) throws {
    
    // MARK: - DB
    
    if let url = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(url: url), as:.psql)
    } else {
        app.databases.use(.postgres(hostname: "localhost",
                                    port: 5432,
                                    username: "mpantiru",
                                    password: "",
                                    database: "cavalerii"), as:.psql)
    }

    // MARK: - Migrations
    
    app.migrations.add(CreatStudents())
    app.migrations.add(CreatFormResults())
    try app.autoMigrate().wait()

    // MARK: - Routes
    try routes(app)
}
