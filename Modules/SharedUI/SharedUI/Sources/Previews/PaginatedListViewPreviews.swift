//
//  PaginatedListView.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import SharedUI

#Preview {
    PaginatedListView<Bicycle, Text>(
        items: [.babboe, .giant, .trek],
        isLoading: true
    ) { bicycle in
        Text(bicycle.model)
    } loadMore: { _ in
        print("More")
    } refresh: {
        print("Refresh")
    }
}

#Preview {
    PaginatedListView<Bicycle, Text>(
        items: [.babboe, .giant, .trek],
        isLoading: false
    ) { bicycle in
        Text(bicycle.model)
    } loadMore: { _ in
        print("More")
    } refresh: {
        print("Refresh")
    }
}
