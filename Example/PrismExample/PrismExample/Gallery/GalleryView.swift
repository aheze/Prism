//
//  GalleryView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

enum ExampleKind: String {
    case basic = "Basic"
    case slime = "Slime"
    case transform = "Transform"
    case logo = "Logo"
    case interaction = "Interaction"
    case island = "Island"

    case color = "Color"
    case gradient = "Gradient"
    case image = "Image"
    case glass = "Glass"
}

struct GalleryView: View {
    @ObservedObject var model: ViewModel

    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            Section {
                BasicGalleryView(model: model)

                SlimeGalleryView(model: model)

                TransformGalleryView(model: model)
                
                LogoGalleryView(model: model)
                
                InteractionGalleryView(model: model)
                
                IslandGalleryView(model: model)
            } header: {
                Text("Showcase")
                    .foregroundColor(UIColor.secondaryLabel.color)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Section {
                ColorGalleryView(model: model)

                GradientGalleryView(model: model)

                ImageGalleryView(model: model)

                GlassGalleryView(model: model)
            } header: {
                Text("Templates")
                    .foregroundColor(UIColor.secondaryLabel.color)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
            }
        }
        .padding(.horizontal, 20)
        .navigationDestination(for: ExampleKind.self) { kind in
            switch kind {
            case .basic:
                BasicDetailView()
            case .slime:
                SlimeDetailView()
            case .transform:
                TransformDetailView()
            case .logo:
                LogoDetailView()
            case .interaction:
                InteractionDetailView()
            case .island:
                IslandDetailView()
            case .color:
                ColorDetailView()
            case .gradient:
                GradientDetailView()
            case .image:
                ImageDetailView()
            case .glass:
                GlassDetailView()
            }
        }
    }
}
