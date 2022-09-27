//
//  Logo.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct LogoGalleryView: View {
    @ObservedObject var model: ViewModel
    @State var configuration = PrismConfiguration(
        tilt: 1,
        size: .init(width: 60, height: 60),
        extrusion: 60
    )

    var body: some View {
        GalleryCardView(model: model, kind: .logo) {
            PrismCanvas(tilt: configuration.tilt) {
                LogoPrismView(configuration: $configuration)
            }
            .scaleEffect(y: 0.76)
            .frame(minHeight: 240)
            .offset(y: 20)
        }
    }
}

struct LogoDetailView: View {
    @State var configuration = PrismConfiguration(
        tilt: 1,
        size: .init(width: 150, height: 150),
        extrusion: 150
    )

    var body: some View {
        PrismCanvas(tilt: configuration.tilt) {
            LogoPrismView(configuration: $configuration)
        }
        .scaleEffect(y: 0.76)
        .navigationTitle("Logo")
    }
}

struct LogoPrismView: View {
    @Binding var configuration: PrismConfiguration
    var fromRim = UIColor.white.withAlphaComponent(0.5).color
    var toRim = UIColor.white.color
    var fromInner = UIColor.systemBlue.color
    var toInner = UIColor.systemPink.color

    var body: some View {
        PrismView(configuration: configuration) {
            side(from: .topLeading, to: .bottomTrailing, fromColor: Color.pink.opacity(0.75), toColor: Color.white)
        } left: {
            side(from: .bottomTrailing, to: .topTrailing, fromColor: Color.green.opacity(0.75), toColor: Color.white)
        } right: {
            side(from: .bottomTrailing, to: .topLeading, fromColor: Color.yellow.opacity(0.75), toColor: Color.white)
        }
    }

    func side(from: UnitPoint, to: UnitPoint, fromColor: Color, toColor: Color) -> some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundStyle(
                    .linearGradient(
                        stops: [
                            .init(color: fromRim, location: 0),
                            .init(color: toRim, location: 1)
                        ],
                        startPoint: from,
                        endPoint: to
                    )
                    .shadow(
                        .inner(
                            color: .black.opacity(0.1),
                            radius: geometry.size.width / 30,
                            x: 0,
                            y: 0
                        )
                    )
                )
                .overlay {
                    Rectangle()
                        .stroke(Color.black.opacity(0.5), lineWidth: geometry.size.width / 120)
                }
                .opacity(0.7)
                .overlay {
                    Rectangle()
                        .foregroundStyle(
                            .ellipticalGradient(
                                stops: [
                                    .init(color: toColor, location: -0.2),
                                    .init(color: fromColor, location: 1)
                                ],
                                center: to
                            )
                            .shadow(
                                .inner(
                                    color: .black.opacity(0.25),
                                    radius: geometry.size.width / 30,
                                    x: 0,
                                    y: 0
                                )
                            )
                        )
                        .frame(
                            width: geometry.size.width * 2 / 3,
                            height: geometry.size.height * 2 / 3
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
