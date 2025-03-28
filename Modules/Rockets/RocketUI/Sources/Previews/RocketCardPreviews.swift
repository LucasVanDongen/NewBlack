//
//  RocketCardPreviews.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import RocketDefinitions
@testable import RocketMocks
import RocketUI

#Preview {
    NavigationStack {
        VStack {
            RocketCard(rocket: .sampleRocket)
            Spacer()
        }
    }
}
