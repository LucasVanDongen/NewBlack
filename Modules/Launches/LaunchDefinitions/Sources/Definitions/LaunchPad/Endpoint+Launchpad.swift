//
//  LaunchPadEndpoint.swift
//  LaunchDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import RepositoryDefinitions

public extension Endpoint {
    static let launchpads = Endpoint(path: "launchpads", version: .v4, sort: ["date_utc": "desc"])
}
