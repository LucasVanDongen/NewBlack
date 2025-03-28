//
//  RocketCardProviding.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

import RepositoryDefinitions

@MainActor
public protocol RocketCardProviding {
    func makeRocketCard(for rocket: Rocket) -> AnyView
    func makeRocketCard(for rocketId: String) -> AnyView
}
