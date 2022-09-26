//
//  PrismEffect.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    

import SwiftUI

extension View {
    func tiltLeft(tilt: CGFloat) -> some View {
        modifier(
            PrismLeftEffect(tilt: tilt)
        )
    }

    func tiltRight(tilt: CGFloat) -> some View {
        modifier(
            PrismLeftEffect(tilt: tilt)
        )
    }

    func tiltContent(tilt: CGFloat) -> some View {
        modifier(
            PrismContentEffect(tilt: tilt)
        )
    }
}

struct PrismLeftEffect: GeometryEffect {
    var tilt: CGFloat

    var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(a: 1, b: 0, c: tilt, d: 1, tx: 0, ty: 0)
        )
    }
}

struct PrismRightEffect: GeometryEffect {
    var tilt: CGFloat

    var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
            CGAffineTransform(a: tilt, b: tilt + (1 - tilt), c: 0, d: 1, tx: 0, ty: 0)
        )
    }
}

struct PrismContentEffect: GeometryEffect {
    var tilt: CGFloat

    var animatableData: CGFloat {
        get { tilt }
        set { tilt = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
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

