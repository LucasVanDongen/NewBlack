//
//  LaunchpadNameView.swift
//  LaunchUI
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

import LaunchDefinitions
import RepositoryDefinitions
import SharedUI

public struct LaunchpadNameView<Content: View>: View {
    private let launchpadId: String
    @State private var launchpadState: LoadState<Launchpad> = .initial
    private let repository: any Repository<Launchpad>
    private let content: (Launchpad) -> Content

    public init(
        launchpadId: String,
        repository: some Repository<Launchpad>,
        @ViewBuilder content: @escaping (Launchpad) -> Content
    ) {
        self.launchpadId = launchpadId
        self.repository = repository
        self.content = content
    }

    public var body: some View {
        LoadStateView(
            state: launchpadState,
            content: { launchpad in
                content(launchpad)
            },
            retry: {
                await loadLaunchpad()
            }
        )
        .task {
            await loadLaunchpad()
        }
    }

    private func loadLaunchpad() async {
        launchpadState = await repository.getItem(id: launchpadId)
    }
}
