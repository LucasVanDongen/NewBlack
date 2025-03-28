//
//  RocketCardView.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import SwiftUI

import RepositoryDefinitions

public protocol RocketCardViewImplementing: View {
    init(rocketId: String, repository: any Repository<Rocket>)
}
