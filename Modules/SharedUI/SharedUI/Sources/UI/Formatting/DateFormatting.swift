//
//  DateFormatting.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import Foundation

public extension DateFormatter {
    static func formatted(date: Date) -> String {
        Self.dateFormatter.string(from: date)
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
