//
//  PrismConfiguration.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

public struct PrismConfiguration {
    public var tilt = CGFloat(0.25)
    public var size = CGSize(width: 100, height: 100)
    public var extrusion = CGFloat(20)

    public var levitation = CGFloat(0)
    public var shadowColor = Color.black
    public var shadowOpacity = CGFloat(0.25)

    public init(
        tilt: CGFloat = CGFloat(0.25),
        size: CGSize = CGSize(width: 100, height: 100),
        extrusion: CGFloat = CGFloat(20),
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
