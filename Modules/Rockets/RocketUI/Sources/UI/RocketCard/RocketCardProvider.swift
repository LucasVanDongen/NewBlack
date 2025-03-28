//
//  RocketCardProvider.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

import RepositoryDefinitions
import RocketDefinitions

@MainActor
public struct RocketCardProvider: RocketCardProviding {
    private let repository: any Repository<Rocket>

    public init(repository: any Repository<Rocket>) {
        self.repository = repository
    }

    public func makeRocketCard(for rocketId: String) -> AnyView {
        AnyView(RocketCardWithState(rocketId: rocketId, repository: repository))
    }

    public func makeRocketCard(for rocket: Rocket) -> AnyView {
        AnyView(RocketCard(rocket: rocket))
    }
}
