//
//  LaunchAPIService.swift
//  LaunchDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import Foundation

import RepositoryDefinitions

public protocol LaunchAPIService {
    func fetchLaunch(id: String) async throws -> Launch
    func fetchLaunches(startDate: Date?, endDate: Date?, page: Int, limit: Int) async throws -> PaginatedResponse<Launch>
}
