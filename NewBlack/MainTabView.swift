//
//  MainTabView.swift
//  NewBlack
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import LaunchDefinitions
import LaunchUI
import RepositoryDefinitions
import RocketDefinitions
import RocketUI
import SharedUI

public struct MainTabView: View {
    private let launchRepository: any Repository<Launch>
    private let launchpadRepository: any Repository<Launchpad>
    private let rocketRepository: any Repository<Rocket>

    public init(
        launchRepository: some Repository<Launch>,
        launchpadRepository: some Repository<Launchpad>,
        rocketRepository: some Repository<Rocket>
    ) {
        self.launchRepository = launchRepository
        self.launchpadRepository = launchpadRepository
        self.rocketRepository = rocketRepository
    }
    
    public var body: some View {
        TabView {
            NavigationStack {
                LaunchesListView(
                    rocketCardProvider: RocketCardProvider(repository: rocketRepository),
                    repository: launchRepository,
                    launchpadRepository: launchpadRepository
                )
            }.tabItem {
                Image(systemName: "calendar")
                Text("Launches")
            }

            NavigationStack {
                RocketsListView(repository: rocketRepository)
            }.tabItem {
                Image(systemName: "list.star")
                Text("Rockets")
            }
        }
    }
}
