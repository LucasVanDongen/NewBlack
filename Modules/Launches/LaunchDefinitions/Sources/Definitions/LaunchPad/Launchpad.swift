//
//  Launchpad.swift
//  LaunchDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import Foundation

import RepositoryDefinitions

public struct Launchpad: Identifiable, Decodable, Sendable {
    public let id: String
    public let name: String
    public let fullName: String
    public let locality: String
    public let region: String
    public let timezone: String
    public let latitude: Double
    public let longitude: Double
    public let launchAttempts: Int
    public let launchSuccesses: Int
    public let rockets: [String]
    public let launches: [String]
    public let status: String
    
    public init(
        id: String,
        name: String,
        fullName: String,
        locality: String,
        region: String,
        timezone: String,
        latitude: Double,
        longitude: Double,
        launchAttempts: Int,
        launchSuccesses: Int,
        rockets: [String],
        launches: [String],
        status: String
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.locality = locality
        self.region = region
        self.timezone = timezone
        self.latitude = latitude
        self.longitude = longitude
        self.launchAttempts = launchAttempts
        self.launchSuccesses = launchSuccesses
        self.rockets = rockets
        self.launches = launches
        self.status = status
    }
}

extension Launchpad: SkeletonProviding {
    public static let skeleton = Launchpad(
        id: "skeleton-id",
        name: "Loading...",
        fullName: "Loading Launchpad...",
        locality: "City",
        region: "Region",
        timezone: "UTC",
        latitude: 0.0,
        longitude: 0.0,
        launchAttempts: 0,
        launchSuccesses: 0,
        rockets: [],
        launches: [],
        status: "unknown"
    )
}
