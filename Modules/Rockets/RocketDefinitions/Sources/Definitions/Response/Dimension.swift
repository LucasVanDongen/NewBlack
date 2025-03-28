//
//  Dimension.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

public struct Dimension: Decodable, Sendable {
    public let meters: Double?
    public let feet: Double?

    public init(
        meters: Double? = nil,
        feet: Double? = nil
    ) {
        self.meters = meters
        self.feet = feet
    }
}
