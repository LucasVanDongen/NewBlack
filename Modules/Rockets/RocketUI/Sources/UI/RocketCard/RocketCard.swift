//
//  RocketCard.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import RocketDefinitions

public struct RocketCard: View {
    public let rocket: Rocket

    public init(rocket: Rocket) {
        self.rocket = rocket
    }

    public var body: some View {
        NavigationLink(destination: RocketDetailContent(rocket: rocket)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(rocket.name)
                    .font(.headline)
                
                Text(rocket.type)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
    }
}
