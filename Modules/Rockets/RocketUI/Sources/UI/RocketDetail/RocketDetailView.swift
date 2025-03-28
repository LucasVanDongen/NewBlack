//
//  RocketDetailView.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import RepositoryDefinitions
import RocketDefinitions
import SharedUI

struct RocketDetailView: View {
    let rocketId: String
    @State private var repository: any Repository<Rocket>
    @State private var rocketState: LoadState<Rocket> = .initial
    
    init(rocketId: String, repository: some Repository<Rocket>) {
        self.rocketId = rocketId
        self.repository = repository
    }
    
    var body: some View {
        LoadStateView(
            state: rocketState,
            content: { rocket in
                RocketDetailContent(rocket: rocket)
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
