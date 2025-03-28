//
//  StatusBadge.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

struct StatusBadge: View {
    let isActive: Bool
    
    var body: some View {
        Text(isActive ? "Active" : "Inactive")
            .font(.caption.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isActive ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
            .foregroundStyle(isActive ? Color.green : Color.red)
            .clipShape(Capsule())
    }
}
