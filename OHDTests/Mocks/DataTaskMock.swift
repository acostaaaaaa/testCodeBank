//
//  URLProtocolMock.swift
//  MagicTests
//

import Foundation
@testable import OHD

// MARK: - DataTaskMock class
class DataTaskMock: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        print("Resume called")
    }
}
