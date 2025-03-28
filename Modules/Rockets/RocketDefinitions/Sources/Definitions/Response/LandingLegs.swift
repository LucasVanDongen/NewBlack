//
//  LandingLegs.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

public struct LandingLegs: Decodable, Sendable {
    public let number: Int
    public let material: String?

    public init(
        number: Int,
        material: String? = nil
    ) {
        self.number = number
        self.material = material
    }
}
