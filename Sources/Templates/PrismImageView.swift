//
//  PrismImageView.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

public struct PrismImageView: View {
    var configuration: PrismConfiguration
    var image: Image

    public init(
        configuration: PrismConfiguration,
        image: Image
    ) {
        self.configuration = configuration
        self.image = image
    }

    public var body: some View {
        let image = Color.clear.overlay(
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .clipped()

        PrismView(configuration: configuration) {
            image
        } left: {
            image.brightness(-0.1)
        } right: {
            image.brightness(-0.3)
        }
    }
}

public extension PrismImageView {
    init(
        tilt: CGFloat,
        size: CGSize,
        extrusion: CGFloat,
        levitation: CGFloat = CGFloat(0),
        shadowColor: SwiftUI.Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25),
        image: Image
    ) {
        let configuration = PrismConfiguration(
            tilt: tilt,
            size: size,
            extrusion: extrusion,
            levitation: levitation,
            shadowColor: shadowColor,
            shadowOpacity: shadowOpacity
        )
        self.configuration = configuration
        self.image = image
    }
}
