//
//  PrismView.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

struct PrismView<Content: View, Left: View, Right: View>: View {
    var size: CGSize
    var tilt: CGFloat
    var extrusion: CGFloat
    var levitation = CGFloat(0)
    var shadowColor = Color.black
    var shadowOpacity = CGFloat(0.25)

    @ViewBuilder let content: Content
    @ViewBuilder let left: Left
    @ViewBuilder let right: Right

    var body: some View {
        let topRightOffset = tilt * size.width
        let topAngle = atan2(topRightOffset, size.width)

        let extrusionOffset: CGFloat = {
            let extrusionOffset = extrusion
            return extrusionOffset
        }()

        let levitationXOffset = sin(topAngle) * levitation
        let levitationYOffset = cos(topAngle) * levitation
        let extrusionXOffset = sin(topAngle) * extrusionOffset
        let extrusionYOffset = cos(topAngle) * extrusionOffset

        content
            .frame(width: size.width, height: size.height)
            .background(alignment: .bottom) {
                left
                    .frame(width: size.width, height: extrusionYOffset)
                    .tiltLeft(tilt: tilt)
                    .offset(y: extrusionYOffset)
            }
            .background(alignment: .trailing) {
                Color.clear
                    .frame(width: extrusionYOffset, height: size.height)
                    .overlay(
                        right
                            .frame(width: size.height, height: extrusionYOffset)
                            .rotationEffect(.degrees(-90))
                    )
                    .tiltRight(tilt: tilt)
                    .offset(x: extrusionYOffset)
            }
            .background(
                shadowColor
                    .shadow(
                        color: shadowColor,
                        radius: 16,
                        x: 0,
                        y: 0
                    )
                    .offset(
                        x: levitationXOffset + extrusionXOffset + 10,
                        y: levitationYOffset + extrusionYOffset + 10
                    )
                    .opacity(shadowOpacity)
                    .opacity(CGFloat(1) - (CGFloat(levitation) / 400))
                    .blur(radius: 10 + CGFloat(levitation) / 12)
            )
            .offset(x: -levitationXOffset, y: -levitationYOffset) /// z height effect
            .offset(x: -extrusionXOffset, y: -extrusionYOffset) /// extrusion effect
    }
}
