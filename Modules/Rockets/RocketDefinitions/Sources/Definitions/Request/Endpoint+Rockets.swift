//
//  Endpoint+Rockets.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import RepositoryDefinitions

public extension Endpoint {
    static let rockets = Endpoint(path: "rockets", version: .v4, sort: ["name": "asc"])
}
