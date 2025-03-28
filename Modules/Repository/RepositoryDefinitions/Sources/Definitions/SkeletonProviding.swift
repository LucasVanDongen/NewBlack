//
//  SkeletonProviding.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

// FIXME: this was a really neat idea but it somehow stalled the UI on the Rockets tab
public protocol SkeletonProviding {
    static var skeleton: Self { get }
}
