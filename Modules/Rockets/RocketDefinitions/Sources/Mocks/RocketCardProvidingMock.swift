//
//  RocketCardProvidingMock.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

import RepositoryDefinitions
import RocketDefinitions

struct MockRocketCard: View, RocketCardViewImplementing {
    let rocketId: String
    let repository: any Repository<Rocket>

    var body: some View {
        Text("Rocket number \(rocketId)")
    }
}

struct RocketCardProvidingMock: RocketCardProviding {
    func makeRocketCard(for rocketId: String, repository: any Repository<Rocket>) -> AnyView {
        AnyView(MockRocketCard(rocketId: rocketId, repository: repository))
    }
}
