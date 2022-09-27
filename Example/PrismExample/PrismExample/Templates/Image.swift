//
//  Image.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct ImageGalleryView: View {
    @ObservedObject var model: ViewModel

    var body: some View {
        GalleryTemplateCardView(model: model, kind: .image) {
            PrismImageView(
                tilt: model.configuration.tilt,
                size: model.configuration.size,
                extrusion: model.configuration.extrusion,
                levitation: model.configuration.levitation,
                shadowColor: model.configuration.shadowColor,
                shadowOpacity: model.configuration.shadowOpacity,
                image: Image("Sample") /// Default photo from https://unsplash.com/@hunterrei
            )
        }
    }
}

struct ImageDetailView: View {
    @State var image = Image("Sample")

    var body: some View {
        DetailView { configuration in
            PrismImageView(
                tilt: configuration.tilt,
                size: configuration.size,
                extrusion: configuration.extrusion,
                levitation: configuration.levitation,
                shadowColor: configuration.shadowColor,
                shadowOpacity: configuration.shadowOpacity,
                image: image
            )
        } controls: {}
            .navigationTitle("Image")
    }
}
