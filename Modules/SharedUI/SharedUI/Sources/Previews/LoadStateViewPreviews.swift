//
//  LoadStateView.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import RepositoryDefinitions
import RepositoryMocks
import SharedUI

enum FakeError: Error {
    case fake
}

struct TestView: View {
    let state: LoadState<Bicycle>

    var body: some View {
        LoadStateView(state: state) { bicycle in
            HStack {
                bicycle.color
                    .frame(width: 20)
                VStack(alignment: .leading) {
                    Text(bicycle.brand).fontWeight(.bold)
                    Text(bicycle.model)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
            }
        } retry: {
            print("Retried")
        }
    }
}

#Preview {
    VStack {
        TestView(state: .initial)
        TestView(state: .loading)
        TestView(state: .refreshing(current: .babboe))
        TestView(state: .loaded(data: .giant, isFresh: true))
        TestView(state: .loaded(data: .trek, isFresh: false))
        TestView(state: .error(FakeError.fake))
    }
}
