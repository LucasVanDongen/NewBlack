//
//  class.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import RepositoryDefinitions
import Foundation

class MockAPIService: APIService {
    // Call counts
    var fetchItemsCallCount = 0
    var fetchItemCallCount = 0

    // Arguments
    var fetchItemsEndpointArguments: [Endpoint] = []
    var fetchItemsPageArguments: [Int] = []
    var fetchItemEndpointArguments: [Endpoint] = []
    var fetchItemIdArguments: [String] = []

    // Stubbed responses - we'll use Any and then cast it in the implementation
    var stubbedFetchItemsResult: Any = NSError(domain: "Not configured", code: 0)
    var stubbedFetchItemResult: Any = NSError(domain: "Not configured", code: 0)

    func fetchItems<T>(endpoint: Endpoint, page: Int, limit: Int) async throws -> RepositoryDefinitions.PaginatedResponse<T> where T : Decodable {
        fetchItemsCallCount += 1
        fetchItemsEndpointArguments.append(endpoint)
        fetchItemsPageArguments.append(page)

        if let error = stubbedFetchItemsResult as? Error {
            throw error
        }

        guard let response = stubbedFetchItemsResult as? PaginatedResponse<T> else {
            throw NSError(domain: "MockAPIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Type mismatch in stubbedFetchItemsResult"])
        }

        return response
    }

    func fetchItem<T: Decodable>(endpoint: Endpoint, id: String) async throws -> T {
        fetchItemCallCount += 1
        fetchItemEndpointArguments.append(endpoint)
        fetchItemIdArguments.append(id)

        if let error = stubbedFetchItemResult as? Error {
            throw error
        }

        guard let item = stubbedFetchItemResult as? T else {
            throw NSError(domain: "MockAPIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Type mismatch in stubbedFetchItemResult"])
        }

        return item
    }
}
