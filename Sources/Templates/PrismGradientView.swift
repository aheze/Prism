//
//  PrismGradientView.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A template for a gradient prism.
 */
public struct PrismGradientView: View {
    var configuration: PrismConfiguration
    var gradient: Gradient

    /**
     A template for a gradient prism.
     */
    public init(
        configuration: PrismConfiguration,
        gradient: Gradient
    ) {
        self.configuration = configuration
        self.gradient = gradient
    }

    public var body: some View {
        PrismView(configuration: configuration) {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        } left: {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .brightness(-0.1)
        } right: {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .brightness(-0.3)
        }
    }
}

public extension PrismGradientView {
    /**
     A template for a gradient prism. This is a convenience initializer.
     */
    init(
        tilt: CGFloat,
        size: CGSize,
        extrusion: CGFloat,
        levitation: CGFloat = CGFloat(0),
        shadowColor: SwiftUI.Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25),
        gradient: Gradient
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
        self.gradient = gradient
    }
}
