//
//  URLSessionMock.swift
//  MagicTests
//

import Foundation
@testable import OHD

// MARK: - MockURLSession class
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer { completionHandler(data, response, error) }
        return DataTaskMock(completionHandler: completionHandler)
    }
}
