//
//  LoadState.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation

public enum LoadState<T: Sendable>: Sendable {
    case initial
    case loading
    case refreshing(current: T)
    case loaded(data: T, isFresh: Bool)
    case error(Error)
    
    public var currentData: T? {
        switch self {
        case .loaded(let data, _):
            return data
        case .refreshing(let current):
            return current
        default:
            return nil
        }
    }
    
    public var isLoading: Bool {
        switch self {
        case .loading, .refreshing:
            return true
        default:
            return false
        }
    }
}
