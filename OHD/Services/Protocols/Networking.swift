//
//  Networking.swift
//  Magic
//

import Foundation

// MARK: - NetworkingService protocol
protocol NetworkingService {
    var endpoint: String { get set }
    var session: URLSessionProtocol { get set }
    func fetchData(completion: @escaping (_ response: NetworkResponse) -> Void)
}

// MARK: - NetworkResponse enum
enum NetworkResponse {
    case success(Any)
    case failure(NetworkError)
}

// MARK: - NetworkError enum
enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case unknown
    case noInternet
    case serverError
    case parseFailure
    
    var description: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString(LocalizedKeys.invalidURL.rawValue, comment: "Not a correct URL")
        case .noInternet:
            return NSLocalizedString(LocalizedKeys.noInternet.rawValue, comment: "Not having an internet connection")
        case .unknown:
            return NSLocalizedString(LocalizedKeys.unknownError.rawValue, comment: "Error that was not anticipated")
        case .serverError:
            return NSLocalizedString(LocalizedKeys.serverError.rawValue, comment: "Error that ocurred somewhere else")
        case .parseFailure:
            return NSLocalizedString(LocalizedKeys.parseFailure.rawValue, comment: "Data was not in the correct format")
        }
    }
}
