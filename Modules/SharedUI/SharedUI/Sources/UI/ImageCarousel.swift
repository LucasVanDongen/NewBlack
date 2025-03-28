//
//  ImageCarousel.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

public struct ImageCarousel: View {
    public let imageURLs: [URL]
    @State private var selectedIndex = 0

    public init(imageURLs: [URL], selectedIndex: Int = 0) {
        self.imageURLs = imageURLs
        self.selectedIndex = selectedIndex
    }

    public var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<imageURLs.count, id: \.self) { index in
                AsyncImage(url: imageURLs[index]) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "photo")
                            .imageScale(.large)
                    @unknown default:
                        EmptyView()
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}
