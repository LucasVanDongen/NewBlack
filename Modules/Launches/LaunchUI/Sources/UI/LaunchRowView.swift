//
//  LaunchRowView.swift
//  LaunchUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import LaunchDefinitions
import RepositoryDefinitions
import SharedUI

public struct LaunchRowView: View {
    private let launch: Launch
    private let launchpadRepository: any Repository<Launchpad>

    public init(
        launch: Launch,
        launchpadRepository: some Repository<Launchpad>
    ) {
        self.launch = launch
        self.launchpadRepository = launchpadRepository
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(launch.name)
                .font(.headline)

            //LaunchpadNameView(launchpadId: launch.launchpad, repository: launchpadRepository) { launchpad in
            Text(launch.launchpad.name)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            //}

            HStack {
                Text(DateFormatter.formatted(date: launch.dateLocal))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                launchStatusBadge
            }
        }
        .padding(.vertical, 8)
    }
    
    private var launchStatusBadge: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            
            Text(statusText)
                .font(.caption)
                .foregroundStyle(statusColor)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(statusColor.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var statusColor: Color {
        if launch.upcoming {
            return .blue
        } else if let success = launch.success, success {
            return .green
        } else {
            return .red
        }
    }
    
    private var statusText: String {
        if launch.upcoming {
            return "Upcoming"
        } else if let success = launch.success, success {
            return "Success"
        } else {
            return "Failed"
        }
    }
}
