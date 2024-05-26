import Foundation

public struct Incident: Decodable {
    public let id, description: String
    public let latitude, longitude: Double
    public let status: Int
    public let priority: Int?
    public let typeId: Int
    public let issuerId, createdAt, updatedAt: String
    public let assigneeId: String?
    public let medias: [Media]
}

public struct Media: Decodable {
    public let id, mimeType: String
    public let url: String
    public let type: Int
    public let incidentId: String
}
