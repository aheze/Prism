//
//  PrismEffect.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

public extension View {
    /// Perspective transform for the left side of the extruded prism.
    func tiltLeft(tilt: CGFloat) -> some View {
        modifier(
            PrismLeftEffect(tilt: tilt)
        )
    }

    /// Perspective transform for the right side of the extruded prism.
    func tiltRight(tilt: CGFloat) -> some View {
        modifier(
            PrismRightEffect(tilt: tilt)
        )
    }
    
    /// Mirror the right side on the left.
    func tiltRightMirror(tilt: CGFloat) -> some View {
        modifier(
            PrismRightMirrorEffect(tilt: tilt)
        )
    }
    

    /// Perspective transform for the top side of the extruded prism.
    func tiltContent(tilt: CGFloat) -> some View {
        modifier(
            PrismContentEffect(tilt: tilt)
        )
    }
}

/// Perspective transform for the left side of the extruded prism.
public struct PrismLeftEffect: GeometryEffect {
    public var tilt: CGFloat

    public var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(a: 1, b: 0, c: tilt, d: 1, tx: 0, ty: 0)
        )
    }
}

/// Perspective transform for the right side of the extruded prism.
public struct PrismRightEffect: GeometryEffect {
    public var tilt: CGFloat

    public var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(a: tilt, b: 1, c: 0, d: 1, tx: 0, ty: 0)
        )
    }
}

//public struct PrismRightMirrorEffect: GeometryEffect {
//    public var tilt: CGFloat
//
//    public var animatableData: CGFloat {
//        get { tilt }
//        set { tilt = newValue }
//    }
//
//    public func effectValue(size: CGSize) -> ProjectionTransform {
//        return ProjectionTransform(
//            CGAffineTransform(a: -tilt, b: tilt + (1 - tilt), c: 0, d: 1, tx: 0, ty: 0)
//        )
//    }
//}

/// Perspective transform for the top side of the extruded prism.
public struct PrismContentEffect: GeometryEffect {
    public var tilt: CGFloat

    public var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        let tx: CGFloat = size.height * tilt / 2
        let ty: CGFloat = size.width * tilt / 2

        return ProjectionTransform(
            CGAffineTransform(
                a: 1,
                b: tilt,
                c: -tilt,
                d: 1,
                tx: tx,
                ty: -ty
            )
        )
    }
}
