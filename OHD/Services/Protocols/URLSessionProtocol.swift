//
//  URLSessionProtocol.swift
//  Magic
//

import Foundation

// MARK: - URLSessionProtocol protocol
protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

// MARK: - URLSession extension
extension URLSession: URLSessionProtocol { }
