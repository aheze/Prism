//
//  PrismGlassView.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A template for a glass-style prism.
 */
public struct PrismGlassView: View {
    var configuration: PrismConfiguration
    var color: Color
    var opacity: CGFloat

    /**
     A template for a glass-style prism.
     */
    public init(
        configuration: PrismConfiguration,
        color: Color,
        opacity: CGFloat
    ) {
        self.configuration = configuration
        self.color = color
        self.opacity = opacity
    }

    public var body: some View {
        PrismView(configuration: configuration) {
            color
                .opacity(opacity - 0.2)
        } left: {
            color.brightness(-0.1)
                .opacity(opacity - 0.1)
        } right: {
            color.brightness(-0.3)
                .opacity(opacity)
        }
    }
}

public extension PrismGlassView {
    /**
     A template for a glass-style prism. This is a convenience initializer.
     */
    init(
        tilt: CGFloat,
        size: CGSize,
        extrusion: CGFloat,
        levitation: CGFloat = CGFloat(0),
        shadowColor: SwiftUI.Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25),
        color: Color,
        opacity: CGFloat
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
        self.color = color
        self.opacity = opacity
    }
}
