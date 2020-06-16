import Fluent
import Vapor

final class Student: Model, Content {
    static let schema = "students"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .name)
    var name: String
    
    @Field(key: .className)
    var className: String
    
    @Field(key: .device)
    var device: String
    
    @Field(key: .reason)
    var reason: String
    
    @Timestamp(key: .createdAt, on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, name: String, className: String, device: String, reason: String) {
        self.id = id
        self.name = name
        self.className = className
        self.device = device
        self.reason = reason
    }
}

extension FieldKey {
    static var name: Self { "name" }
    static var className: Self { "class" }
    static var device: Self { "device" }
    static var reason: Self { "reason" }
    static var createdAt: Self { "created_at" }
}
