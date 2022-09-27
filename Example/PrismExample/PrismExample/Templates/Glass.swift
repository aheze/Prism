//
//  Glass.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct GlassGalleryView: View {
    @ObservedObject var model: ViewModel

    var body: some View {
        GalleryTemplateCardView(model: model, kind: .glass) {
            PrismGlassView(
                tilt: model.configuration.tilt,
                size: model.configuration.size,
                extrusion: model.configuration.extrusion,
                levitation: model.configuration.levitation,
                shadowColor: model.configuration.shadowColor,
                shadowOpacity: model.configuration.shadowOpacity,
                color: .blue,
                opacity: 0.5
            )
        }
    }
}

struct GlassDetailView: View {
    @State var color = Color.blue
    @State var opacity = CGFloat(0.5)
    var body: some View {
        DetailView { configuration in
            PrismGlassView(
                tilt: configuration.tilt,
                size: configuration.size,
                extrusion: configuration.extrusion,
                levitation: configuration.levitation,
                shadowColor: configuration.shadowColor,
                shadowOpacity: configuration.shadowOpacity,
                color: color,
                opacity: opacity
            )
        } controls: {
            ExampleColorView(title: "Color", value: $color)
            ExampleSliderView(title: "Opacity", value: $opacity, range: 0 ... 1)
        }
        .navigationTitle("Glass")
    }
}
