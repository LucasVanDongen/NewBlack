//
//  SpaceXModel.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation

public protocol SpaceXModel: Identifiable, Codable, Equatable {
    var id: String { get }
}
