//
//  ImageCarousel.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

struct ImageCarousel: View {
    let imageURLs: [URL]
    @State private var selectedIndex = 0
    
    var body: some View {
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
