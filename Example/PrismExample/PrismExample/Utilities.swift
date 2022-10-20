//
//  Utilities.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        var animation: Animation?

        /// only change when it's different
        if isPressed != configuration.isPressed {
            if configuration.isPressed {
                animation = .spring(
                    response: 0.1,
                    dampingFraction: 0.6,
                    blendDuration: 1
                )
            } else {
                animation = .spring(
                    response: 0.4,
                    dampingFraction: 0.4,
                    blendDuration: 1
                )
            }

            DispatchQueue.main.async {
                withAnimation(animation) {
                    isPressed = configuration.isPressed
                }
            }
        }

        return configuration.label
            .opacity(1) /// needs a modifier to actually be called
    }
}

struct ScalingButtonStyle: ButtonStyle {
    var scale = CGFloat(0.95)
    func makeBody(configuration: Configuration) -> some View {
        var animation: Animation?

        if configuration.isPressed {
            /// pressing down
            animation = .spring(
                response: 0.19,
                dampingFraction: 0.45,
                blendDuration: 1
            )
        } else {
            animation = .spring(
                response: 0.4,
                dampingFraction: 0.4,
                blendDuration: 1
            )
        }

        return configuration.label
            .opacity(configuration.isPressed ? 0.95 : 1)
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(animation, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScalingButtonStyle {
    static var scaling: ScalingButtonStyle {
        ScalingButtonStyle()
    }

    static func scaling(_ scale: CGFloat) -> ScalingButtonStyle {
        ScalingButtonStyle(scale: scale)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1),
            alpha: 1.0
        )
    }

    var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }

    /// Get a gradient color.
    func offset(by offset: CGFloat) -> UIColor {
        let (h, s, b, a) = hsba
        var newHue = h - offset

        /// Wrap back to positive values.
        while newHue <= 0 {
            newHue += 1
        }
        let normalizedHue = newHue.truncatingRemainder(dividingBy: 1)
        return UIColor(hue: normalizedHue, saturation: s, brightness: b, alpha: a)
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(hex: UInt(hex), alpha: alpha)
    }

    convenience init(hex: UInt, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    /// darken or lighten
    func adjust(by offset: CGFloat) -> UIColor {
        let (r, g, b) = rgb
        let newR = r + offset
        let newG = g + offset
        let newB = b + offset

        return UIColor(red: newR, green: newG, blue: newB, alpha: 1)
    }

    var rgb: (r: CGFloat, g: CGFloat, b: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r: r, g: g, b: b)
        } else {
            return (0, 0, 0)
        }
    }
}

extension Color {
    init(hex: UInt, alpha: CGFloat = 1) {
        self.init(UIColor(hex: hex, alpha: alpha))
    }
}
