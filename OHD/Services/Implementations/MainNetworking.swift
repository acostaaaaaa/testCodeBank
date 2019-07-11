//
//  MainNetworking.swift
//  Magic
//

import Foundation

// MARK: - MainNetworking struct
struct MainNetworking<T>: NetworkingService where T: Codable {
    var session: URLSessionProtocol
    var endpoint: String
    var dataParser = MainParser<T>()
    
    init(endpoint: String, session: URLSessionProtocol = URLSession.shared) {
        self.endpoint = endpoint
        self.session = session
    }
    
    func fetchData(completion: @escaping (_ response: NetworkResponse) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(NetworkResponse.failure(.unknown))
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                if let error = error, (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    completion(NetworkResponse.failure(.noInternet))
                } else if let error = error, (500 ... 521).contains((error as NSError).code) {
                    completion(NetworkResponse.failure(.serverError))
                } else {
                    completion(NetworkResponse.failure(.unknown))
                }
                return
            }
            
            switch response.statusCode {
            case 200 ..< 300:
                if let information = self.dataParser.parse(data: data) {
                    completion(NetworkResponse.success(information))
                } else {
                    completion(NetworkResponse.failure(.parseFailure))
                }
            case NSURLErrorNotConnectedToInternet:
                completion(NetworkResponse.failure(.noInternet))
            case 500 ... 521:
                completion(NetworkResponse.failure(.serverError))
            default:
                completion(NetworkResponse.failure(.unknown))
            }
        }
        dataTask.resume()
    }
}

// MARK: - MainNetworking extension
extension MainNetworking {

    static var main: NetworkingService {
        guard let urlString = Bundle.urlString(for: "MAIN_SECTIONS_URL") else {
            fatalError("There was a problem with the jobs url in Magic.xcconfig file")
        }
        
        return MainNetworking<T>(endpoint: urlString)
    }
    
    static var work: NetworkingService {
        guard let urlString = Bundle.urlString(for: "JOBS_URL") else {
            fatalError("There was a problem with the jobs url in Magic.xcconfig file")
        }
        
        return MainNetworking<T>(endpoint: urlString)
    }

    static var basic: NetworkingService {
        guard let urlString = Bundle.urlString(for: "PROFILE_URL") else {
            fatalError("There was a problem with the jobs url in Magic.xcconfig file")
        }
        
        return MainNetworking<T>(endpoint: urlString)
    }
}

extension Bundle {
    static func urlString(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
