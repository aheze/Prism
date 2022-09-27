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
}

struct GalleryView: View {
    @ObservedObject var model: ViewModel

    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            GalleryColorView(model: model)

            GalleryColorView(model: model)

            GalleryColorView(model: model)
        }
        .padding(.horizontal, 20)
        .navigationDestination(for: DetailKind.self) { kind in
            switch kind {
            case .color:
                ColorView()
            }
        }
    }
}

struct GalleryColorView: View {
    @ObservedObject var model: ViewModel

    var body: some View {
        GalleryCardView(model: model, kind: .color) {
            PrismColorView(
                tilt: model.configuration.tilt,
                size: model.configuration.size,
                extrusion: model.configuration.extrusion,
                levitation: model.configuration.levitation,
                shadowColor: model.configuration.shadowColor,
                shadowOpacity: model.configuration.shadowOpacity,
                color: .blue
            )
        }
    }
}

struct GalleryCardView<Content: View>: View {
    @ObservedObject var model: ViewModel
    var kind: DetailKind
    @ViewBuilder var content: Content

    var body: some View {
        Button {
            model.path.append(kind)
        } label: {
            VStack(spacing: 0) {
                PrismCanvas(configuration: model.configuration) {
                    content
                }
                .frame(minHeight: 160)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                Divider()

                HStack {
                    Text(kind.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 16)

                    Image(systemName: "chevron.right")
                        .foregroundColor(UIColor.secondaryLabel.color)
                }
                .padding(.horizontal, 16)
            }
            .foregroundColor(UIColor.label.color)
            .background(UIColor.systemBackground.color)
            .cornerRadius(16)
        }
    }
}
