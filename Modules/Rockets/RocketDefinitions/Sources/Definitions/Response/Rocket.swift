//
//  Rocket.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import Foundation

import RepositoryDefinitions

public struct Rocket: Identifiable, Decodable, Sendable {
    public let id: String
    public let name: String
    public let type: String
    public let active: Bool
    public let stages: Int
    public let boosters: Int
    public let costPerLaunch: Int
    public let successRatePct: Int
    public let firstFlight: Date
    public let country: String
    public let company: String
    public let height: Dimension
    public let diameter: Dimension
    public let mass: Mass
    public let payloadWeights: [PayloadWeight]
    public let firstStage: Stage
    public let secondStage: Stage
    public let engines: EngineInfo
    public let landingLegs: LandingLegs
    public let flickrImages: [URL]
    public let wikipedia: URL?
    public  let description: String

    public init(
        id: String,
        name: String,
        type: String,
        active: Bool,
        stages: Int,
        boosters: Int,
        costPerLaunch: Int,
        successRatePct: Int,
        firstFlight: Date,
        country: String,
        company: String,
        height: Dimension,
        diameter: Dimension,
        mass: Mass,
        payloadWeights: [PayloadWeight],
        firstStage: Stage,
        secondStage: Stage,
        engines: EngineInfo,
        landingLegs: LandingLegs,
        flickrImages: [URL],
        wikipedia: URL? = nil,
        description: String
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.active = active
        self.stages = stages
        self.boosters = boosters
        self.costPerLaunch = costPerLaunch
        self.successRatePct = successRatePct
        self.firstFlight = firstFlight
        self.country = country
        self.company = company
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.payloadWeights = payloadWeights
        self.firstStage = firstStage
        self.secondStage = secondStage
        self.engines = engines
        self.landingLegs = landingLegs
        self.flickrImages = flickrImages
        self.wikipedia = wikipedia
        self.description = description
    }
}

//extension Rocket: SkeletonProviding {
//    public static var skeleton: Rocket {
//        Rocket(
//            id: UUID().uuidString,
//            name: "Loading...",
//            type: "Unknown",
//            active: false,
//            stages: 0,
//            boosters: 0,
//            costPerLaunch: 0,
//            successRatePct: 0,
//            firstFlight: Date(),
//            country: "Loading...",
//            company: "SpaceX",
//            height: Dimension(meters: 0, feet: 0),
//            diameter: Dimension(meters: 0, feet: 0),
//            mass: Mass(kg: 0, lb: 0),
//            payloadWeights: [],
//            firstStage: Stage(reusable: false, engines: 0, fuelAmountTons: 0, burnTimeSec: 0),
//            secondStage: Stage(reusable: false, engines: 0, fuelAmountTons: 0, burnTimeSec: 0),
//            engines: EngineInfo(
//                number: 0,
//                type: "Loading...",
//                version: "Loading...",
//                layout: nil,
//                propellant1: "Loading...",
//                propellant2: "Loading..."
//            ),
//            landingLegs: LandingLegs(number: 0, material: nil),
//            flickrImages: [],
//            wikipedia: nil,
//            description: "Loading rocket information..."
//        )
//    }
//}
//
//extension Array: @retroactive SkeletonProviding where Element == Rocket {
//    public static let skeleton: [Rocket] = [
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
