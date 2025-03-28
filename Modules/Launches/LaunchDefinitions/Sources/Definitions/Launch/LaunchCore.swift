//
//  LaunchCore.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//


import Foundation

public struct LaunchCore: Decodable, Sendable {
    public let core: String?
    public let flight: Int?
    public let reused: Bool?
    public let landingSuccess: Bool?
    public let landingType: LandingType?

    public init(
        core: String?,
        flight: Int?,
        reused: Bool?,
        landingSuccess: Bool?,
        landingType: LandingType?
    ) {
        self.core = core
        self.flight = flight
        self.reused = reused
        self.landingSuccess = landingSuccess
        self.landingType = landingType
    }
}
