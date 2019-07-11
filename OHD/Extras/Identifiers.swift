//
//  Identifiers.swift
//  Magic
//

import Foundation

// MARK: - Identifier enum
enum Identifier {
    enum Cell {
        static let main = "main"
        static let work = "work"
    }
}

// MARK: - Localized keys
enum LocalizedKeys: String {
    case invalidURL = "invalid_url"
    case noInternet = "no_internet"
    case serverError = "server_error"
    case parseFailure = "parse_error"
    case unknownError = "unknown_error"
    case genericError = "generic_error"
    case error = "error"
    case years = "years"
    case title = "title"
    case retry = "retry"
    case workExperience = "work_experience"
    case basicInfo = "basic_info"
    case name = "name"
    case age = "age"
    case email = "email"
    case phone = "phone"
    case website = "website"
    case summary = "summary"
}
