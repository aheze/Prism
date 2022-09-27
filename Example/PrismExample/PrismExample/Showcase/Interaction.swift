//
//  Interaction.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/27/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct InteractionGalleryView: View {
    @ObservedObject var model: ViewModel
    @State var configuration = PrismConfiguration(
        tilt: 1,
        size: .init(width: 60, height: 60),
        extrusion: 60
    )

    var body: some View {
        GalleryCardView(model: model, kind: .interaction) {
            PrismCanvas(tilt: configuration.tilt) {
                InteractionPrismView(configuration: configuration)
            }
            .scaleEffect(y: 0.76)
            .allowsHitTesting(false)
            .frame(minHeight: 240)
            .offset(y: 20)
        }
    }
}

struct InteractionDetailView: View {
    @State var configuration = PrismConfiguration(
        tilt: 1,
        size: .init(width: 60, height: 60),
        extrusion: 60
    )

    var body: some View {
        PrismCanvas(tilt: configuration.tilt) {
            InteractionPrismView(configuration: configuration)
        }
        .scaleEffect(y: 0.76)
        .navigationTitle("Interaction")
    }
}

class InteractionPrismViewModel: ObservableObject {
    @Published var rotateBlue = false
    @Published var rotateRed = false
    @Published var rotateGreen = false

    func rotate(keyPath: ReferenceWritableKeyPath<InteractionPrismViewModel, Bool>) {
        withAnimation(.spring()) {
            self[keyPath: keyPath] = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation(.spring()) {
                self[keyPath: keyPath] = false
            }
        }
    }
}

struct InteractionPrismView: View {
    var configuration: PrismConfiguration
    @StateObject var model = InteractionPrismViewModel()

    var body: some View {
        PrismView(configuration: configuration) {
            Button {
                model.rotate(keyPath: \.rotateBlue)
            } label: {
                Color.blue
                    .rotationEffect(.degrees(model.rotateBlue ? 180 : 0))
            }
            .buttonStyle(.scaling)
        } left: {
            Button {
                model.rotate(keyPath: \.rotateRed)
            } label: {
                Color.red
                    .rotationEffect(.degrees(model.rotateRed ? 180 : 0))
            }
            .buttonStyle(.scaling)
        } right: {
            Button {
                model.rotate(keyPath: \.rotateGreen)
            } label: {
                Color.green
                    .rotationEffect(.degrees(model.rotateGreen ? 180 : 0))
            }
            .buttonStyle(.scaling)
        }
    }
}
