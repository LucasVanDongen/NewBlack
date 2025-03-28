//
//  ContentView.swift
//  NewBlack
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import LaunchDefinitions
import LaunchImplementations
import RepositoryImplementations
import RocketDefinitions

struct ContentView: View {
    private let service = SpaceXAPIService()
    private let launchService = SpaceXAPIService()
    var body: some View {
        MainTabView(
            launchRepository: LaunchRepository(service: SpaceXLaunchAPIService()),
            launchpadRepository: SpaceXRepository<Launchpad>(apiService: service, endpoint: .launchpads),
            rocketRepository: SpaceXRepository<Rocket>(apiService: SpaceXAPIService(), endpoint: .rockets)
        )
    }
}
