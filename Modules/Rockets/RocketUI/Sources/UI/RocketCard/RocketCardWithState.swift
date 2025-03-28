//
//  RocketCardWithState.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

import RepositoryDefinitions
import RocketDefinitions
import SharedUI

public struct RocketCardWithState: View, RocketCardViewImplementing {
    let rocketId: String
    let repository: any Repository<Rocket>
    @State private var rocketState: LoadState<Rocket> = .initial

    public init(
        rocketId: String,
        repository: any Repository<Rocket>
    ) {
        self.rocketId = rocketId
        self.repository = repository
    }

    public var body: some View {
        LoadStateView(
            state: rocketState,
            content: { rocket in
                RocketCard(rocket: rocket)
            },
            retry: {
                await loadRocket()
            }
        )
        .task {
            await loadRocket()
        }
    }

    private func loadRocket() async {
        rocketState = await repository.getItem(id: rocketId)
    }
}
