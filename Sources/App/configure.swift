import Fluent
import FluentPostgresDriver
import Vapor
import VaporSecurityHeaders

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
    
    // MARK: - Middlewares
    
    let cspConfig = ContentSecurityPolicyConfiguration(value: CSPKeywords.all)
    let securityHeadersFactory = SecurityHeadersFactory().with(contentSecurityPolicy: cspConfig)
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let corsMiddleware = CORSMiddleware(configuration: corsConfiguration)
    
    app.middleware = Middlewares()
    app.middleware.use(securityHeadersFactory.build())
    app.middleware.use(corsMiddleware)
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))

    // MARK: - Migrations
    
    app.migrations.add(CreatStudents())
    app.migrations.add(CreatFormResults())
    try app.autoMigrate().wait()

    // MARK: - Routes
    try routes(app)
}
