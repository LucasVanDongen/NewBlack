//
//  DetailRow.swift
//  LaunchUI
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

public struct DetailRow: View {
    private let icon: String, title: String, value: String

    public init(
        icon: String,
        title: String,
        value: String
    ) {
        self.icon = icon
        self.title = title
        self.value = value
    }

    public var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .frame(width: 24, height: 24)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.body)
            }
        }
        .padding(.vertical, 4)
    }
}
