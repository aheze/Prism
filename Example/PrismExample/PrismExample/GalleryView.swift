//
//  GalleryView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct GalleryView: View {
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        LazyVGrid(columns: columns) {}
    }
}

struct GalleryColorView: View {
    var configuration: PrismConfiguration
    var body: some View {
        PrismColorView(
            tilt: configuration.tilt,
            size: configuration.size,
            extrusion: configuration.extrusion,
            levitation: configuration.levitation,
            shadowColor: configuration.shadowColor,
            shadowOpacity: configuration.shadowOpacity,
            color: .blue
        )
    }
}
