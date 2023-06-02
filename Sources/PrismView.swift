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
                    .offset(x: extrusionYOffset)
                    .opacity(configuration.tilt > 0 ? 1 : 0),
                alignment: .trailing
            )
            .background( /// The right mirror / left side of the prism.
                Color.clear
                    .frame(width: extrusionYOffset, height: configuration.size.height)
                    .overlay(
                        right
                            .frame(width: configuration.size.height, height: extrusionYOffset)
                            .rotationEffect(.degrees(-90))
                    )
                    .tiltRight(tilt: configuration.tilt)
                    .opacity(configuration.tilt > 0 ? 0 : 1),
                alignment: .leading
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

struct PrismViewPreview: View {
    @State var tilt = CGFloat(-0.5)

    var body: some View {
        VStack {
            PrismCanvas(tilt: tilt) {
                PrismView(tilt: tilt, size: CGSize(width: 50, height: 50), extrusion: 50) {
                    Color.blue
                } left: {
                    Color.green
                } right: {
                    Color.orange
                }
            }

            Slider(value: $tilt, in: -1 ... 1)
        }
    }
}

struct PrismViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        PrismViewPreview()
    }
}

public struct PrismRightMirrorEffect: GeometryEffect {
    public var tilt: CGFloat

    public var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            //            CGAffineTransform.identity
//                .concatenating(CGAffineTransform(scaleX: 4, y: 1))
//                .concatenating(CGAffineTransform(rotationAngle: 0.5))
//            CGAffineTransform(a: tilt, b: -tilt + (1 - tilt), c: 0, d: 1, tx: 0, ty: 0)
//            CGAffineTransform(a: tilt, b: tilt + (1 - tilt), c: 0, d: 1, tx: 0, ty: 0)
//            CGAffineTransform(a: tilt, b: tilt + (1 - tilt), c: 0, d: 1, tx: 0, ty: 0)
//            CGAffineTransform(a: tilt + (1 - tilt), b: 0, c: tilt, d: 1, tx: 0, ty: 0)
//            CGAffineTransform(a: tilt, b: 1, c: 0, d: 1, tx: 0, ty: 0)
            CGAffineTransform(a: -tilt, b: -1, c: 0, d: 1, tx: 0, ty: 0)
        )
    }
}

/// left
// CGAffineTransform(a: 1, b: 0, c: tilt, d: 1, tx: 0, ty: 0)

/// right
// CGAffineTransform(a: tilt, b: 1, c: 0, d: 1, tx: 0, ty: 0)
