//
//  PrismColorView.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

public struct PrismColorView: View {
    // MARK: - Basic configuration

    var configuration: PrismConfiguration
    var color: Color

    public init(
        configuration: PrismConfiguration,
        color: Color
    ) {
        self.configuration = configuration
        self.color = color
    }

    public var body: some View {
        PrismView(configuration: configuration) {
            color
        } left: {
            color.brightness(-0.1)
        } right: {
            color.brightness(-0.3)
        }
    }
}

public extension PrismColorView {
    init(
        tilt: CGFloat,
        size: CGSize,
        extrusion: CGFloat,
        levitation: CGFloat = CGFloat(0),
        shadowColor: SwiftUI.Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25),
        color: Color
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
    }
}
