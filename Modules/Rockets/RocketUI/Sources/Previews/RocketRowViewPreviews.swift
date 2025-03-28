//
//  RocketRowViewPreviews.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import RocketDefinitions
@testable import RocketUI
@testable import RocketMocks

#Preview {
    NavigationStack {
        NavigationLink {
            RocketDetailContent(rocket: .sampleRocket)
        } label: {
            RocketRowView(rocket: .sampleRocket)
        }
        Spacer()
    }
}
