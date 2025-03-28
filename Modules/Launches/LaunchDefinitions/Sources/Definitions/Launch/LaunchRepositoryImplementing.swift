//
//  LaunchRepositoryImplementing.swift
//  LaunchDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import Foundation

public protocol LaunchRepositoryImplementing {
    func filterByDateRange(start: Date?, end: Date?) async
}
