//
//  NumberFormatting.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import Foundation

public extension NumberFormatter {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    static func formatted(currency value: Int) -> String {
        return formatter.string(from: NSNumber(value: value)) ?? "$\(value)"
    }
}
