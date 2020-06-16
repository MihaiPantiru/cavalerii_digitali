import Fluent
import Vapor

final class FormResult: Model, Content {
    static let schema = "form_results"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .name)
    var name: String
    
    @Field(key: .address)
    var address: String
    
    @Field(key: .birthDate)
    var birthDate: String
    
    @Field(key: .outOfCountry)
    var outOfCountry: Bool
    
    @Field(key: .hasSymptoms)
    var hasSymptoms: Bool
    
    @Field(key: .symptoms)
    var symptoms: [String]
    
    @Timestamp(key: .createdAt, on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, name: String, address: String, birthDate: String, outOfCountry: Bool, hasSymptoms: Bool, symptoms: [String]) {
        self.id = id
        self.name = name
        self.address = address
        self.birthDate = birthDate
        self.outOfCountry = outOfCountry
        self.hasSymptoms = hasSymptoms
        self.symptoms = symptoms
    }
}

extension FieldKey {
    static var address: Self { "address" }
    static var birthDate: Self { "birth_date" }
    static var outOfCountry: Self { "out_of_country" }
    static var hasSymptoms: Self { "has_symptoms" }
    static var symptoms: Self { "symptoms" }
}
