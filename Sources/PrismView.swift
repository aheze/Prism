//
//  PrismView.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A 3D prism. Must be placed inside a `PrismCanvas.`
 */
public struct PrismView<Content: View, Left: View, Right: View>: View {
    public var configuration: PrismConfiguration
    @ViewBuilder public var content: Content
    @ViewBuilder public var left: Left
    @ViewBuilder public var right: Right

    /**
     A 3D prism. Must be placed inside a `PrismCanvas.`
     */
    public init(
        configuration: PrismConfiguration,
        @ViewBuilder content: () -> Content,
        @ViewBuilder left: () -> Left,
        @ViewBuilder right: () -> Right
    ) {
        self.configuration = configuration
        self.content = content()
        self.left = left()
        self.right = right()
    }

    public var body: some View {
        let topRightOffset = configuration.tilt * configuration.size.width
        let topAngle = atan2(topRightOffset, configuration.size.width)

        let levitationXOffset = sin(topAngle) * configuration.levitation
        let levitationYOffset = cos(topAngle) * configuration.levitation
        let extrusionXOffset = sin(topAngle) * configuration.extrusion
        let extrusionYOffset = cos(topAngle) * configuration.extrusion

        content /// The top side of the prism.
            .frame(width: configuration.size.width, height: configuration.size.height)
            .background( /// The left side of the prism.
                left
                    .frame(width: configuration.size.width, height: extrusionYOffset)
                    .tiltLeft(tilt: configuration.tilt)
                    .offset(y: extrusionYOffset),
                alignment: .bottom
            )
            .background( /// The right side of the prism.
                Color.clear
                    .frame(width: extrusionYOffset, height: configuration.size.height)
                    .overlay(
                        right
                            .frame(width: configuration.size.height, height: extrusionYOffset)
                            .rotationEffect(.degrees(-90))
                    )
                    .tiltRight(tilt: configuration.tilt)
                    .offset(x: extrusionYOffset),
                alignment: .trailing
            )

            /// Apply the background.
            .background(
                configuration.shadowColor
                    .shadow(
                        color: configuration.shadowColor,
                        radius: 16,
                        x: 0,
                        y: 0
                    )
                    .offset(
                        x: levitationXOffset + extrusionXOffset + 10,
                        y: levitationYOffset + extrusionYOffset + 10
                    )
                    .opacity(configuration.shadowOpacity)
                    .opacity(CGFloat(1) - (CGFloat(configuration.levitation) / 400)) /// Adjust the shadow and blue based on the `levitation`value.
                    .blur(radius: 10 + CGFloat(configuration.levitation) / 12)
            )
            .offset(x: -levitationXOffset, y: -levitationYOffset) /// Z height effect.
            .offset(x: -extrusionXOffset, y: -extrusionYOffset) /// Extrusion effect.
    }
}

public extension PrismView {
    /**
     A 3D prism. Must be placed inside a `PrismCanvas`. This is a convenience initializer.
     */
    init(
        tilt: CGFloat,
        size: CGSize,
        extrusion: CGFloat,
        levitation: CGFloat = CGFloat(0),
        shadowColor: SwiftUI.Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25),
        @ViewBuilder content: () -> Content,
        @ViewBuilder left: () -> Left,
        @ViewBuilder right: () -> Right
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
        self.content = content()
        self.left = left()
        self.right = right()
    }
}
