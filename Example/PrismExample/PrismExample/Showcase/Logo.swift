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
            .scaleEffect(y: 0.78)
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
        .scaleEffect(y: 0.78)
        .navigationTitle("Logo")
    }
}

struct LogoPrismView: View {
    @Binding var configuration: PrismConfiguration

    var body: some View {
        PrismView(configuration: configuration) {
            LinearGradient(
                colors: [
                    UIColor.systemBlue.color,
                    UIColor.systemBlue.offset(by: 0.02).color
                ],
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .opacity(0.75)
            .overlay {
                sticker(point: .bottomTrailing)
            }
        } left: {
            LinearGradient(
                colors: [
                    UIColor.systemBlue.color,
                    UIColor.systemBlue.offset(by: 0.02).color
                ],
                startPoint: .trailing,
                endPoint: .leading
            )
            .opacity(0.7)
            .overlay {
                sticker(point: .topTrailing)
            }
        } right: {
            LinearGradient(
                colors: [
                    UIColor.systemBlue.color,
                    UIColor.systemBlue.offset(by: 0.02).color
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            .brightness(-0.1)
            .opacity(0.7)
            .overlay {
                sticker(point: .topLeading)
            }
        }
    }

    func sticker(point: UnitPoint) -> some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundStyle(
                    .ellipticalGradient(
                        stops: [
                            .init(color: UIColor.systemBlue.offset(by: -0.01).color, location: -0.2),
                            .init(color: UIColor.systemBlue.offset(by: 0.01).color, location: 1)
                        ],
                        center: point
                    )
                    .shadow(
                        .inner(
                            color: .black.opacity(0.1),
                            radius: geometry.size.width / 10,
                            x: 0,
                            y: 0
                        )
                    )
                )
                .frame(
                    width: geometry.size.width * 2 / 3,
                    height: geometry.size.height * 2 / 3
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
