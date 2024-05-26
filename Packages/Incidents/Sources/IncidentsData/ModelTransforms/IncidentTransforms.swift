import IncidentsDomain
import SharedData
import Foundation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return formatter
}()

extension IncidentsDomain.Incident {
    public init(incident: SharedData.Incident) throws {
        self.init(
            id: incident.id,
            description: incident.description,
            latitude: incident.latitude,
            longitude: incident.longitude,
            status: try .init(status: incident.status),
            priority: incident.priority ?? .max,
            workerId: incident.assigneeId,
            imageURL: (incident.medias.first?.url).flatMap(URL.init(string:)),
            createdAt: try Self.parseDate(incident.createdAt)
        )
    }
    
    private static func parseDate(_ dateString: String) throws -> Date {
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            throw IncidentTransformError.unhandledDateFormat(dateString: dateString)
        }
    }
}

extension IncidentsDomain.Incident.Status {
    public init(status: Int) throws {
        switch status {
        case 0:
            self = .submitted
        case 1:
            self = .inProgress
        case 2:
            self = .completed
        case 3:
            self = .rejected
        default:
            throw IncidentTransformError.unknownStatusId(statusId: status)
        }
    }
}

public enum IncidentTransformError: Error {
    case unknownStatusId(statusId: Int)
    case unhandledDateFormat(dateString: String)
}
