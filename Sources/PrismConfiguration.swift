//
//  PrismConfiguration.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 Values used for configuring `PrismView`.
 */
public struct PrismConfiguration {
    /// How much to tilt the prism by. This must match the `tilt` passed into `PrismCanvas`.
    public var tilt = CGFloat(0.25)

    /// The width and height of the prism.
    public var size = CGSize(width: 100, height: 100)

    /// The extrusion of the prism.
    public var extrusion = CGFloat(30)

    /// The levitation (float) of the prism.
    public var levitation = CGFloat(0)

    /// The color of the shadow.
    public var shadowColor = Color.black

    /// The opacity of the shadow. Automatically adjusts as needed based on `levitation`.
    public var shadowOpacity = CGFloat(0.25)

    /**
     Values used for configuring `PrismView`.
     */
    public init(
        tilt: CGFloat = CGFloat(0.25),
        size: CGSize = CGSize(width: 100, height: 100),
        extrusion: CGFloat = CGFloat(30),
        levitation: CGFloat = CGFloat(0),
        shadowColor: Color = Color.black,
        shadowOpacity: CGFloat = CGFloat(0.25)
    ) {
        self.tilt = tilt
        self.size = size
        self.extrusion = extrusion
        self.levitation = levitation
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
    }
}
