//
//  APIService.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation

public protocol APIService {
    func fetchItems<T: Decodable>(endpoint: Endpoint, page: Int, limit: Int) async throws -> PaginatedResponse<T>
    func fetchItem<T: Decodable>(endpoint: Endpoint, id: String) async throws -> T
}
