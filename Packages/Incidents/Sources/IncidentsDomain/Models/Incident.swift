import Foundation

public struct Incident {
    public let id: String
    public let description: String
    public let latitude: Double
    public let longitude: Double
    public let status: Status
    public let priority: Int
    public let workerId: String?
    public let imageURL: URL?
    
    public init(
        id: String,
        description: String,
        latitude: Double,
        longitude: Double,
        status: Status,
        priority: Int,
        workerId: String?,
        imageURL: URL?
    ) {
        self.id = id
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
        self.priority = priority
        self.workerId = workerId
        self.imageURL = imageURL
    }
}

extension Incident {
    public enum Status {
        case submitted
        case inProgress
        case completed
        case rejected
    }
}
