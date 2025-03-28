//
//  Launch.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import Foundation

import RepositoryDefinitions
import RocketDefinitions

public struct Launch: Identifiable, Decodable, Sendable {
    public let id: String
    public let name: String
    public let flightNumber: Int
    public let dateUtc: Date
    public let dateUnix: Int
    public let dateLocal: Date
    public let datePrecision: DatePrecision
    public let upcoming: Bool
    public let success: Bool?
    public let details: String?
    public let rocket: Rocket
    public let launchpad: Launchpad
    public let links: LaunchLinks
    public let cores: [LaunchCore]

    public init(
        id: String,
        name: String,
        flightNumber: Int,
        dateUtc: Date,
        dateUnix: Int,
        dateLocal: Date,
        datePrecision: DatePrecision,
        upcoming: Bool,
        success: Bool?,
        details: String?,
        rocket: Rocket,
        launchpad: Launchpad,
        links: LaunchLinks,
        cores: [LaunchCore]
    ) {
        self.id = id
        self.name = name
        self.flightNumber = flightNumber
        self.dateUtc = dateUtc
        self.dateUnix = dateUnix
        self.dateLocal = dateLocal
        self.datePrecision = datePrecision
        self.upcoming = upcoming
        self.success = success
        self.details = details
        self.rocket = rocket
        self.launchpad = launchpad
        self.links = links
        self.cores = cores
    }
}

public enum DatePrecision: String, Decodable, Sendable {
    case hour, day, month, quarter, year, half
}

public enum LandingType: String, Decodable, Sendable {
    case asds = "ASDS" // Autonomous Spaceport Drone Ship
    case rtls = "RTLS" // Return To Launch Site
    case ocean = "Ocean"
}
//
//extension Launch: SkeletonProviding {
//    public static var skeleton: Launch {
//        Launch(
//            id: UUID().uuidString,
//            name: "Loading...",
//            flightNumber: 0,
//            dateUtc: Date(),
//            dateUnix: 0,
//            dateLocal: Date(),
//            datePrecision: .day,
//            upcoming: false,
//            success: nil,
//            details: "Loading launch information...",
//            rocket: "skeleton-rocket-id",
//            launchpad: "skeleton-launchpad-id",
//            links: LaunchLinks(
//                patch: PatchLinks(small: nil, large: nil),
//                webcast: nil,
//                article: nil,
//                wikipedia: nil,
//                flickr: FlickrLinks(small: [], original: [])
//            ),
//            cores: []
//        )
//    }
//}
//
//extension Array: @retroactive SkeletonProviding where Element == Launch {
//    public static let skeleton: [Launch] = [
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton,
//        .skeleton
//    ]
//}
