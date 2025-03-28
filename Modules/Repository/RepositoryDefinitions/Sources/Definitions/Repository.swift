//
//  Repository.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation

public protocol Repository<T>: Sendable {
    associatedtype T: Decodable & Identifiable & Sendable
    
    // State
    var state: LoadState<[T]> { get }
    
    // Core operations
    func load() async
    func refresh() async
    func loadMore(after item: T) async
    
    // Single item operations
    func getItem(id: T.ID) async -> LoadState<T>
    func refreshItem(id: T.ID) async -> LoadState<T>
}
