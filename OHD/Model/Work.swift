//
//  Work.swift
//  Magic
//

import Foundation

// MARK: - WorkData struct
struct WorkData: Codable {
    var company: String
    var position: String
    var startDate: String
    var endDate: String?
    var summary: String
}
