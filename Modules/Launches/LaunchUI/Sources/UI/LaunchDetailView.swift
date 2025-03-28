//
//  LaunchDetailView.swift
//  LaunchUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import LaunchDefinitions
import RepositoryDefinitions
import RocketDefinitions
import SharedUI

public struct LaunchDetailView: View {
    @State private var repository: any Repository<Launch>
    private let launchpadRepository: any Repository<Launchpad>
    @State private var launchState: LoadState<Launch> = .initial

    private let launchId: String
    private let rocketCardProvider: RocketCardProviding

    public init(
        launchId: String,
        rocketCardProvider: RocketCardProviding,
        repository: some Repository<Launch>,
        launchpadRepository: any Repository<Launchpad>
    ) {
        self.launchId = launchId
        self.rocketCardProvider = rocketCardProvider
        self._repository = State(initialValue: repository)
        self.launchpadRepository = launchpadRepository
    }
    
    public var body: some View {
        LoadStateView(
            state: launchState,
            content: { launch in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Mission Patch or Flickr image
                        launchImageView(launch)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(launch.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            // Status badge
                            launchStatusBadge(launch)
                            
                            // Launch details
                            DetailRow(icon: "calendar", title: "Date", value: formattedDate(launch.dateLocal))
                            //LaunchpadNameView(launchpadId: launch.launchpad, repository: launchpadRepository) { launchpad in
                            DetailRow(icon: "mappin.and.ellipse", title: "Launch Site", value: launch.launchpad.fullName)
                            //}

                            if let details = launch.details, !details.isEmpty {
                                Text("Mission Description")
                                    .font(.headline)
                                    .padding(.top, 8)
                                
                                Text(details)
                                    .font(.body)
                            }
                            
                            // Watch launch button
                            if let webcastURL = launch.links.webcast {
                                Link(destination: webcastURL) {
                                    HStack {
                                        Image(systemName: "play.circle.fill")
                                        Text("Watch Launch")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                                .padding(.vertical)
                            }
                            
                            rocketCardProvider.makeRocketCard(for: launch.rocket)
                        }
                        .padding()
                    }
                }
            },
            retry: {
                await loadLaunch()
            }
        )
        .navigationTitle("Launch Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadLaunch()
        }
    }
    
    private func loadLaunch() async {
        launchState = await repository.getItem(id: launchId)
    }

    private func launchImageView(_ launch: Launch) -> some View {
        Group {
            if let patchURL = launch.links.patch?.large ?? launch.links.patch?.small,
               !launch.links.flickr.original.isEmpty {
                AsyncImage(url: patchURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200)
                            .frame(maxWidth: .infinity)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    } else {
                        ProgressView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    }
                }
            } else if !launch.links.flickr.original.isEmpty {
                AsyncImage(url: launch.links.flickr.original[0]) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    } else {
                        ProgressView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    }
                }
            } else {
                // Placeholder if no image is available
                Image(systemName: "photo.artframe")
                    .font(.system(size: 64))
                    .foregroundColor(.gray)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
            }
        }
        .background(Color(.secondarySystemBackground))
    }
    
    private func launchStatusBadge(_ launch: Launch) -> some View {
        HStack(spacing: 4) {
            Circle()
                .fill(statusColor(launch))
                .frame(width: 8, height: 8)
            
            Text(statusText(launch))
                .font(.subheadline)
                .foregroundStyle(statusColor(launch))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(statusColor(launch).opacity(0.1))
        .cornerRadius(10)
    }
    
    private func statusColor(_ launch: Launch) -> Color {
        if launch.upcoming {
            return .blue
        } else if let success = launch.success, success {
            return .green
        } else {
            return .red
        }
    }
    
    private func statusText(_ launch: Launch) -> String {
        if launch.upcoming {
            return "Upcoming"
        } else if let success = launch.success, success {
            return "Success"
        } else {
            return "Failed"
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
