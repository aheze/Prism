//
//  Color.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct ColorGalleryView: View {
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

struct ColorDetailView: View {
    @State var color = Color.blue
    var body: some View {
        DetailView { configuration in
            PrismColorView(
                tilt: configuration.tilt,
                size: configuration.size,
                extrusion: configuration.extrusion,
                levitation: configuration.levitation,
                shadowColor: configuration.shadowColor,
                shadowOpacity: configuration.shadowOpacity,
                color: color
            )
        } controls: {
            ExampleColorView(title: "Color", value: $color)
        }
        .navigationTitle("Color")
    }
}
