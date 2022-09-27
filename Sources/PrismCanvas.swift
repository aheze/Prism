//
//  PrismCanvas.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 The base view for prisms.

 This applies a perspective transform to simulate a 3D effect.
 */
public struct PrismCanvas<Content: View>: View {
    public var tilt: CGFloat
    public var content: Content

    public init(
        tilt: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self.tilt = tilt
        self.content = content()
    }

    public var body: some View {
        content
            .tiltContent(tilt: tilt)
    }
}


public extension PrismCanvas {
    /**
     The base view for prisms.

     This applies a perspective transform to simulate a 3D effect.
     
     This is a convenience initializer.
     */
    init(
        configuration: PrismConfiguration,
        @ViewBuilder content: () -> Content
    ) {
        self.tilt = configuration.tilt
        self.content = content()
    }
}
