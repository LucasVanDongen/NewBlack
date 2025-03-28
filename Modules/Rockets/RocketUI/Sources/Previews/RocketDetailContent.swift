//
//  RocketDetailContent.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import RocketDefinitions

@testable import RocketMocks
@testable import RocketUI

struct RocketDetailContent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RocketDetailContent(rocket: .sampleRocket)
        }
    }
}
