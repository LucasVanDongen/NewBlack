//
//  Stage.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

public struct Stage: Decodable, Sendable {
    public let reusable: Bool
    public let engines: Int?
    public let fuelAmountTons: Double?
    public let burnTimeSec: Int?

    public init(
        reusable: Bool,
        engines: Int? = nil,
        fuelAmountTons: Double? = nil,
        burnTimeSec: Int? = nil
    ) {
        self.reusable = reusable
        self.engines = engines
        self.fuelAmountTons = fuelAmountTons
        self.burnTimeSec = burnTimeSec
    }
}
