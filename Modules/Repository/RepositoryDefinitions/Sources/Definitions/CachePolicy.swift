//
//  CachePolicy.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation

public enum CachePolicy {
    case useCache
    case ignoreCache
    case refreshIfStale(staleAfter: TimeInterval)
}
