//
//  RocketsListView.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import RepositoryDefinitions
import RocketDefinitions
import SharedUI

public struct RocketsListView: View {
    @State private var repository: any Repository<Rocket>
    
    public init(repository: some Repository<Rocket>) {
        self._repository = State(initialValue: repository)
    }
    
    public var body: some View {
        LoadStateView(
            state: repository.state,
            content: { rockets in
                PaginatedListView(
                    items: rockets,
                    isLoading: repository.state.isLoading,
                    rowContent: { rocket in
                        NavigationLink(destination: RocketDetailView(rocketId: rocket.id, repository: repository)) {
                            RocketRowView(rocket: rocket)
                        }
                    },
                    loadMore: { rocket in
                        await repository.loadMore(after: rocket)
                    },
                    refresh: {
                        await repository.refresh()
                    }
                )
            },
            retry: {
                await repository.load()
            }
        )
        .navigationTitle("Rockets")
        .task {
            await repository.load()
        }
    }
}
