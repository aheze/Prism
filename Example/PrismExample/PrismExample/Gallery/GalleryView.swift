//
//  GalleryView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

enum DetailKind: String {
    case color = "Color"
    case gradient = "Gradient"
}

struct GalleryView: View {
    @ObservedObject var model: ViewModel

    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ColorGalleryView(model: model)

            GradientGalleryView(model: model)
        }
        .padding(.horizontal, 20)
        .navigationDestination(for: DetailKind.self) { kind in
            switch kind {
            case .color:
                ColorDetailView()
            case .gradient:
                GradientDetailView()
            }
        }
    }
}
