//
//  Gradient.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct GradientGalleryView: View {
    @ObservedObject var model: ViewModel

    var body: some View {
        GalleryTemplateCardView(model: model, kind: .gradient) {
            PrismGradientView(
                tilt: model.configuration.tilt,
                size: model.configuration.size,
                extrusion: model.configuration.extrusion,
                levitation: model.configuration.levitation,
                shadowColor: model.configuration.shadowColor,
                shadowOpacity: model.configuration.shadowOpacity,
                gradient: .init(colors: [.blue, .teal])
            )
        }
    }
}

struct GradientDetailView: View {
    @State var start = Color.blue
    @State var end = Color.teal

    var body: some View {
        DetailView { configuration in
            PrismGradientView(
                tilt: configuration.tilt,
                size: configuration.size,
                extrusion: configuration.extrusion,
                levitation: configuration.levitation,
                shadowColor: configuration.shadowColor,
                shadowOpacity: configuration.shadowOpacity,
                gradient: .init(colors: [start, end])
            )
        } controls: {
            ExampleColorView(title: "Start", value: $start)
            ExampleColorView(title: "End", value: $end)
        }
        .navigationTitle("Gradient")
    }
}
