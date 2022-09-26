//
//  ColorView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct ColorView: View {
    var body: some View {
        DetailView { configuration in
            PrismColorView(
                tilt: configuration.tilt,
                size: configuration.size,
                extrusion: configuration.extrusion,
                levitation: configuration.levitation,
                shadowColor: configuration.shadowColor,
                shadowOpacity: configuration.shadowOpacity,
                color: .blue
            )
        } controls: {}
    }
}
