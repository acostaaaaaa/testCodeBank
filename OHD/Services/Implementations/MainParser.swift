//
//  MainParser.swift
//  Magic
//

import Foundation

// MARK: - MainParser struct
struct MainParser<T: Codable> {

    func parse(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        
        guard let object = try? jsonDecoder.decode(T.self, from: data) else {
            return nil
        }
        return object
    }
}
