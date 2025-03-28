//
//  ErrorView.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

public struct ErrorView: View {
    private let title: String
    private let message: String
    private let retryAction: () async -> Void

    public init(
        title: String = "Error",
        message: String,
        retryAction: @escaping () async -> Void
    ) {
        self.title = title
        self.message = message
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.red)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Try Again") {
                Task {
                    await retryAction()
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // .background(.)
    }
}
