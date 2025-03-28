//
//  PaginatedListView.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import RepositoryDefinitions

public struct PaginatedListView<T: Identifiable, RowContent: View>: View {
    private let items: [T]
    private let rowContent: (T) -> RowContent
    private let isLoading: Bool
    private let loadMore: (T) async -> Void
    private let refresh: () async -> Void

    public init(
        items: [T],
        isLoading: Bool,
        @ViewBuilder rowContent: @escaping (T) -> RowContent,
        loadMore: @escaping (T) async -> Void,
        refresh: @escaping () async -> Void
    ) {
        self.items = items
        self.rowContent = rowContent
        self.isLoading = isLoading
        self.loadMore = loadMore
        self.refresh = refresh
    }

    public var body: some View {
        List {
            ForEach(items) { item in
                rowContent(item)
                    .task {
                        await loadMore(item)
                    }
            }

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .refreshable {
            await refresh()
        }
    }
}
