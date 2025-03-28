//
//  LoadStateView.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import RepositoryDefinitions

public struct LoadStateView<T: Sendable, Content: View>: View { //  & SkeletonProviding
    private let state: LoadState<T>
    private let content: (T) -> Content
    private let retry: () async -> Void

    public init(
        state: LoadState<T>,
        @ViewBuilder content: @escaping (T) -> Content,
        retry: @escaping () async -> Void
    ) {
        self.state = state
        self.content = content
        self.retry = retry
    }

    public var body: some View {
        Group {
            switch state {
            case .initial, .loading:
                ZStack {
//                    content(T.skeleton)
//                        .redacted(reason: .placeholder)

                    ProgressView()
                }

            case .refreshing(let data), .loaded(let data, _):
                ZStack {
                    content(data)

                    if case .refreshing = state {
                        ProgressView()
                    }
                }

            case .error(let error):
                VStack(spacing: 16) {
                    Text("Error loading data")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    Button("Retry") {
                        Task { await retry() }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
