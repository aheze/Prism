//
//  Slime.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct SlimeGalleryView: View {
    @ObservedObject var model: ViewModel

    var body: some View {
        GalleryCardView(model: model, kind: .slime) {
            PrismCanvas(tilt: model.configuration.tilt) {
                PrismView(
                    tilt: 0.3,
                    size: .init(width: 100, height: 100),
                    extrusion: 60
                ) {
                    Color.green
                        .opacity(0.75)
                } left: {
                    Color.green.brightness(-0.1)
                        .opacity(0.5)
                } right: {
                    Color.green.brightness(-0.3)
                        .opacity(0.5)
                }
            }
            .frame(minHeight: 240)
            .offset(y: 20)
        }
    }
}

struct SlimeDetailView: View {
    static let defaultLength = CGFloat(100)
    static let defaultExtrusion = CGFloat(60)

    @State var displayedConfigurations: [DisplayedPrismConfiguration] = [
        .init(
            configuration: .init(
                tilt: 0.3,
                size: .init(width: defaultLength, height: defaultLength),
                extrusion: defaultExtrusion
            )
        ),
        .init(
            configuration: .init(
                tilt: 0.3,
                size: .init(width: defaultLength, height: defaultLength),
                extrusion: defaultExtrusion
            )
        ),
        .init(
            configuration: .init(
                tilt: 0.3,
                size: .init(width: defaultLength, height: defaultLength),
                extrusion: defaultExtrusion
            )
        ),
    ]

    var body: some View {
        VStack {
            Text("Tap me!")
                .font(.title)
                .foregroundColor(UIColor.secondaryLabel.color)
                .offset(y: -200)

            PrismCanvas(tilt: 0.3) {
                HStack(spacing: 20) {
                    ForEach($displayedConfigurations) { $displayedConfiguration in
                        let configuration = Binding {
                            $displayedConfiguration.wrappedValue.configuration
                        } set: { newValue in
                            $displayedConfiguration.wrappedValue.configuration = newValue
                        }

                        SlimePrismView(configuration: configuration)
                    }
                }
            }
        }
        .navigationTitle("Slime")
    }
}

struct SlimePrismView: View {
    @Binding var configuration: PrismConfiguration
    @State var isPressed = false

    var body: some View {
        Button {} label: {
            PrismView(configuration: configuration) {
                Color.green
                    .opacity(0.75)
            } left: {
                Color.green.brightness(-0.1)
                    .opacity(0.5)
            } right: {
                Color.green.brightness(-0.3)
                    .opacity(0.5)
            }
        }
        .buttonStyle(PressedButtonStyle(isPressed: $isPressed))
        .onChange(of: isPressed) { newValue in
            animate(isPressed: newValue)
        }
    }

    func animate(isPressed: Bool) {
        if isPressed {
            withAnimation(
                .spring(response: 0.21, dampingFraction: 0.5, blendDuration: 1)
            ) {
                configuration.extrusion *= 0.2
            }
        } else {
            withAnimation(
                .spring(response: 0.4, dampingFraction: 0.7, blendDuration: 1)
            ) {
                configuration.extrusion = SlimeDetailView.defaultLength * 3 / 2
                configuration.size = .init(
                    width: SlimeDetailView.defaultLength * 2 / 5,
                    height: SlimeDetailView.defaultLength * 2 / 5
                )
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(
                    .spring(response: 0.3, dampingFraction: 0.7, blendDuration: 1)
                ) {
                    configuration.levitation = SlimeDetailView.defaultLength * 3 / 2
                    configuration.extrusion = 10
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.293) {
                withAnimation(
                    .spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1)
                ) {
                    configuration.size = .init(width: SlimeDetailView.defaultLength, height: SlimeDetailView.defaultLength)
                    configuration.levitation = 0
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
                withAnimation(
                    .spring(response: 0.6, dampingFraction: 0.7, blendDuration: 1)
                ) {
                    configuration.extrusion = SlimeDetailView.defaultExtrusion
                }
            }
        }
    }
}
