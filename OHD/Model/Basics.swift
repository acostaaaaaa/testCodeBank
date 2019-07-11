//
//  Basics.swift
//  Magic
//

import Foundation

// MARK: - BasicInfo struct
struct BasicInfo: Codable {
    var name: String
    var email: String
    var phone: String
    var website: String
    var summary: String
    var age: Int
    
    init(name: String, email: String, phone: String, website: String, summary: String, age: Int) {
        self.name = name
        self.email = email
        self.phone = phone
        self.website = website
        self.summary = summary
        self.age = age
    }
    
    static func empty() -> BasicInfo {
        return BasicInfo(name: "", email: "", phone: "", website: "", summary: "", age: 0)
    }
}
