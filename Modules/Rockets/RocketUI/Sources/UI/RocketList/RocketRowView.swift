//
//  RocketRowView.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import RocketDefinitions

public struct RocketRowView: View {
    public let rocket: Rocket

    public init(rocket: Rocket) {
        self.rocket = rocket
    }

    public var body: some View {
        HStack(spacing: 12) {
            // Rocket image
            if !rocket.flickrImages.isEmpty {
                AsyncImage(url: rocket.flickrImages[0]) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .frame(width: 80, height: 80)
                    } else {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                }
            } else {
                Image(systemName: "rocket.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                    .frame(width: 80, height: 80)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(rocket.name)
                    .font(.headline)
                
                Text(rocket.type)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Label("\(rocket.successRatePct)%", systemImage: "chart.line.uptrend.xyaxis")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(rocket.active ? "Active" : "Inactive")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(rocket.active ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .foregroundColor(rocket.active ? .green : .red)
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
