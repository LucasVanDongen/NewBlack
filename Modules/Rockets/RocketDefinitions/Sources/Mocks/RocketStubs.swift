//
//  RocketStubs.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import Foundation

import RocketDefinitions

public extension Rocket {
    static var sampleRocket: Rocket {
        Rocket(
            id: "falcon9",
            name: "Falcon 9",
            type: "Orbital Launch Vehicle",
            active: true,
            stages: 2,
            boosters: 0,
            costPerLaunch: 50000000,
            successRatePct: 98,
            firstFlight: Date(),
            country: "United States",
            company: "SpaceX",
            height: Dimension(meters: 70, feet: 229.6),
            diameter: Dimension(meters: 3.7, feet: 12),
            mass: Mass(kg: 549054, lb: 1207920),
            payloadWeights: [
                PayloadWeight(id: "leo", name: "Low Earth Orbit", kg: 22800, lb: 50265)
            ],
            firstStage: Stage(
                reusable: true,
                engines: 9,
                fuelAmountTons: 385,
                burnTimeSec: 162
            ),
            secondStage: Stage(
                reusable: false,
                engines: 1,
                fuelAmountTons: 107,
                burnTimeSec: 397
            ),
            engines: EngineInfo(
                number: 9,
                type: "Merlin",
                version: "1D+",
                layout: "octaweb",
                propellant1: "liquid oxygen",
                propellant2: "RP-1 kerosene"
            ),
            landingLegs: LandingLegs(
                number: 4,
                material: "carbon fiber"
            ),
            flickrImages: [
                URL(string: "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg")!,
                URL(string: "https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg")!
            ],
            wikipedia: URL(string: "https://en.wikipedia.org/wiki/Falcon_9"),
            description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit. The Block 5 variant is the fifth major interval aimed at improving upon the ability for rapid reusability."
        )
    }
}
