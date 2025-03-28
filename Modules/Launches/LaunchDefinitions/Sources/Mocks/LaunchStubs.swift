//
//  RocketStubs.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import LaunchDefinitions
import Foundation

public extension Launch {
    static var samples: [Launch] {
        [
            successfulLaunch,
            failedLaunch,
            upcomingLaunch,
            oldLaunch,
            launchWithoutDetails
        ]
    }

    static var successfulLaunch: Launch {
        Launch(
            id: "5eb87d47ffd86e000604b38a",
            name: "Starlink-1",
            flightNumber: 92,
            dateUtc: Date(timeIntervalSince1970: 1590793800),
            dateUnix: 1590793800,
            dateLocal: Date(timeIntervalSince1970: 1590793800),
            datePrecision: .hour,
            upcoming: false,
            success: true,
            details: "This mission launched the first batch of Starlink satellites for global internet coverage. Each satellite weighs approximately 260 kg and features a compact, flat-panel design.",
            rocket: "5e9d0d95eda69974db09d1ed",
            launchpad: "5e9e4502f509094188566f88",
            links: LaunchLinks(
                patch: PatchLinks(
                    small: URL(string: "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png"),
                    large: URL(string: "https://images2.imgbox.com/40/e3/GypSkayF_o.png")
                ),
                webcast: URL(string: "https://www.youtube.com/watch?v=riBaVeDTEWI"),
                article: URL(string: "https://spaceflightnow.com/2020/05/30/spacex-vaults-astronauts-into-orbit/"),
                wikipedia: URL(string: "https://en.wikipedia.org/wiki/Starlink"),
                flickr: FlickrLinks(
                    small: [URL(string: "https://live.staticflickr.com/65535/49927519643_b43c6d4c44_o.jpg")!],
                    original: [URL(string: "https://live.staticflickr.com/65535/49927519643_b43c6d4c44_o.jpg")!]
                )
            ),
            cores: [
                LaunchCore(
                    core: "5e9e28a7f359188aba3b2759",
                    flight: 5,
                    reused: true,
                    landingSuccess: true,
                    landingType: .asds
                )
            ]
        )
    }

    static var failedLaunch: Launch {
        Launch(
            id: "5eb87d4dffd86e000604b394",
            name: "CRS-7",
            flightNumber: 19,
            dateUtc: Date(timeIntervalSince1970: 1435501200),
            dateUnix: 1435501200,
            dateLocal: Date(timeIntervalSince1970: 1435501200),
            datePrecision: .hour,
            upcoming: false,
            success: false,
            details: "Launch failure occurred approximately 2 minutes and 19 seconds into the flight when a strut holding a helium bottle in the second stage broke. This allowed high-pressure helium to escape, causing the stage to overpressurize and explode.",
            rocket: "5e9d0d95eda69973a809d1ec",
            launchpad: "5e9e4501f509094ba4566f84",
            links: LaunchLinks(
                patch: PatchLinks(
                    small: URL(string: "https://images2.imgbox.com/d0/22/gyTVYo21_o.png"),
                    large: URL(string: "https://images2.imgbox.com/44/2e/pe9vXNtw_o.png")
                ),
                webcast: URL(string: "https://www.youtube.com/watch?v=PuNymhcTtSQ"),
                article: URL(string: "https://www.space.com/29994-spacex-rocket-explosion-cause-revealed.html"),
                wikipedia: URL(string: "https://en.wikipedia.org/wiki/SpaceX_CRS-7"),
                flickr: FlickrLinks(
                    small: [],
                    original: []
                )
            ),
            cores: [
                LaunchCore(
                    core: "5e9e289ef35918416a3b2650",
                    flight: 1,
                    reused: false,
                    landingSuccess: false,
                    landingType: nil
                )
            ]
        )
    }

    static var upcomingLaunch: Launch {
        Launch(
            id: "5eb87d4effd86e000604b395",
            name: "Starship SN25",
            flightNumber: 150,
            dateUtc: Date(timeIntervalSinceNow: 2592000), // 30 days in future
            dateUnix: Int(Date().timeIntervalSince1970) + 2592000,
            dateLocal: Date(timeIntervalSinceNow: 2592000),
            datePrecision: .day,
            upcoming: true,
            success: nil,
            details: "Test flight of the Starship vehicle to demonstrate orbital capability and heat shield performance during re-entry.",
            rocket: "5e9d0d96eda699382d09d1ee",
            launchpad: "5e9e4502f509092b78566f87",
            links: LaunchLinks(
                patch: PatchLinks(
                    small: nil,
                    large: nil
                ),
                webcast: nil,
                article: nil,
                wikipedia: URL(string: "https://en.wikipedia.org/wiki/SpaceX_Starship"),
                flickr: FlickrLinks(
                    small: [],
                    original: []
                )
            ),
            cores: [
                LaunchCore(
                    core: "5e9e289ef3591814873b264f",
                    flight: nil,
                    reused: false,
                    landingSuccess: nil,
                    landingType: nil
                )
            ]
        )
    }

    static var oldLaunch: Launch {
        Launch(
            id: "5eb87cddffd86e000604b32a",
            name: "Falcon 1 / FalconSat-2",
            flightNumber: 1,
            dateUtc: Date(timeIntervalSince1970: 1143239400),
            dateUnix: 1143239400,
            dateLocal: Date(timeIntervalSince1970: 1143239400),
            datePrecision: .hour,
            upcoming: false,
            success: false,
            details: "Engine failure at 33 seconds and loss of vehicle. The first privately-developed liquid-fuel rocket to attempt to reach Earth orbit.",
            rocket: "5e9d0d95eda69955f709d1eb",
            launchpad: "5e9e4502f5090995de566f86",
            links: LaunchLinks(
                patch: PatchLinks(
                    small: URL(string: "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png"),
                    large: URL(string: "https://images2.imgbox.com/5b/02/QcxHUb5V_o.png")
                ),
                webcast: nil,
                article: URL(string: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html"),
                wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat"),
                flickr: FlickrLinks(
                    small: [],
                    original: []
                )
            ),
            cores: [
                LaunchCore(
                    core: "5e9e289ef359180b6c3b2633",
                    flight: 1,
                    reused: false,
                    landingSuccess: false,
                    landingType: nil
                )
            ]
        )
    }

    static var launchWithoutDetails: Launch {
        Launch(
            id: "5eb87ce1ffd86e000604b331",
            name: "RazakSat",
            flightNumber: 5,
            dateUtc: Date(timeIntervalSince1970: 1247456100),
            dateUnix: 1247456100,
            dateLocal: Date(timeIntervalSince1970: 1247456100),
            datePrecision: .hour,
            upcoming: false,
            success: true,
            details: nil,
            rocket: "5e9d0d95eda69955f709d1eb",
            launchpad: "5e9e4502f5090995de566f86",
            links: LaunchLinks(
                patch: PatchLinks(
                    small: URL(string: "https://images2.imgbox.com/8d/fc/0qdZMWWx_o.png"),
                    large: URL(string: "https://images2.imgbox.com/a7/ba/NBZSw3Ho_o.png")
                ),
                webcast: nil,
                article: nil,
                wikipedia: nil,
                flickr: FlickrLinks(
                    small: [],
                    original: []
                )
            ),
            cores: [
                LaunchCore(
                    core: "5e9e289ef35918f39c3b2634",
                    flight: 1,
                    reused: false,
                    landingSuccess: false,
                    landingType: .ocean
                )
            ]
        )
    }
}
