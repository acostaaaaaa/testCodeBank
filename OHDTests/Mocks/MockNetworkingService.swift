//
//  MockNetworkingService.swift
//  MagicTests
//

import Foundation
@testable import OHD

// MARK: - MockNetworkingService struct
class MockNetworkingService<T>: NetworkingService where T: Codable {
    var endpoint: String
    var data: Data
    var session: URLSessionProtocol
    var dataParser = MainParser<T>()
    var fetchDataCalled = false

    init(endpoint: String, data: Data, session: URLSessionProtocol = URLSession.shared) {
        self.endpoint = endpoint
        self.data = data
        self.session = session
    }
    
    func fetchData(completion: @escaping (_ response: NetworkResponse) -> Void) {
        fetchDataCalled = true
        if let information = dataParser.parse(data: data) {
            completion(NetworkResponse.success(information))
        } else {
            completion(NetworkResponse.failure(.parseFailure))
        }
    }
}
