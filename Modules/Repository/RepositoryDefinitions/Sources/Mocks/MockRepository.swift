//
//  class.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import Foundation
import RepositoryDefinitions

// Mock for Repository protocol
class MockRepository<T>: @unchecked Sendable, Repository where T: Identifiable & Decodable & Sendable {
    // Protocol properties
    var state: LoadState<[T]> = .initial
    
    // Call counts
    var loadCallCount = 0
    var refreshCallCount = 0
    var loadMoreCallCount = 0
    var getItemCallCount = 0
    var refreshItemCallCount = 0
    
    // Arguments
    var loadMoreItemArguments: [T] = []
    var getItemIdArguments: [T.ID] = []
    var refreshItemIdArguments: [T.ID] = []
    
    // Stubbed responses
    var stubbedGetItemResult: LoadState<T> = .error(NSError(domain: "Not configured", code: 0))
    var stubbedRefreshItemResult: LoadState<T> = .error(NSError(domain: "Not configured", code: 0))
    
    func load() async {
        loadCallCount += 1
    }
    
    func refresh() async {
        refreshCallCount += 1
    }
    
    func loadMore(after item: T) async {
        loadMoreCallCount += 1
        loadMoreItemArguments.append(item)
    }
    
    func getItem(id: T.ID) async -> LoadState<T> {
        getItemCallCount += 1
        getItemIdArguments.append(id)
        return stubbedGetItemResult
    }
    
    func refreshItem(id: T.ID) async -> LoadState<T> {
        refreshItemCallCount += 1
        refreshItemIdArguments.append(id)
        return stubbedRefreshItemResult
    }
}
