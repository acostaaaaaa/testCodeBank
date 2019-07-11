//
//  UILabel+Extensions.swift
//  Magic
//

import Foundation
import UIKit

extension UILabel {
    static func titleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .right
        return label
    }
    
    static func bodyLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }
}
