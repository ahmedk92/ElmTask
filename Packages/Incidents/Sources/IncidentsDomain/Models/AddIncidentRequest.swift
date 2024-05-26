public struct AddIncidentRequest {
    public let description: String
    public let latitude, longitude: Double
    public let status: Incident.Status
    public let typeId: Int
    public let priority: Int
    public let issuerID: String
    
    public init(
        description: String,
        latitude: Double,
        longitude: Double,
        status: Incident.Status,
        typeId: Int,
        priority: Int,
        issuerID: String
    ) {
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
        self.typeId = typeId
        self.priority = priority
        self.issuerID = issuerID
    }
}
