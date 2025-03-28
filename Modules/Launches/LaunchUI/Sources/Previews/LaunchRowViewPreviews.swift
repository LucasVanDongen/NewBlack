//
//  LaunchRowView.swift
//  LaunchUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

@testable import LaunchMocks
import LaunchUI

#Preview {
    VStack {
        LaunchRowView(launch: .upcomingLaunch)
        LaunchRowView(launch: .failedLaunch)
        LaunchRowView(launch: .successfulLaunch)
        LaunchRowView(launch: .oldLaunch)
        LaunchRowView(launch: .launchWithoutDetails)
        Spacer()
    }.padding()
}
