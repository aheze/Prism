//
//  PrismTemplates.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    
import SwiftUI

public struct PrismColorView: View {
    // MARK: - Basic configuration

    var tilt: CGFloat
    var size: CGSize
    var extrusion: CGFloat
    
    // MARK: - Optional properties

    var levitation = CGFloat(0)
    var shadowColor = Color.black
    var shadowOpacity = CGFloat(0.25)
    
    // MARK: - Views

    var color: Color
    
    public init(
        tilt: CGFloat,
        size: CGSize,
        extrusion: CGFloat,
        color: Color,
        levitation: CGFloat = CGFloat(0),
        shadowColor: SwiftUI.Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25)
    ) {
        self.tilt = tilt
        self.size = size
        self.extrusion = extrusion
        self.color = color
        self.levitation = levitation
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
    }
    
    public var body: some View {
        PrismView(
            tilt: tilt,
            size: size,
            extrusion: extrusion,
            levitation: levitation,
            shadowColor: shadowColor,
            shadowOpacity: shadowOpacity
        ) {
            color
        } left: {
            color.brightness(-0.1)
        } right: {
            color.brightness(-0.3)
        }
    }
}
