//
//  Transform.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct TransformGalleryView: View {
    @ObservedObject var model: ViewModel
    @State var configuration = PrismConfiguration(extrusion: 60)

    var body: some View {
        GalleryCardView(model: model, kind: .transform) {
            PrismCanvas(tilt: configuration.tilt) {
                TransformPrismView(configuration: $configuration)
            }
            .allowsHitTesting(false)
            .frame(minHeight: 240)
            .offset(y: 20)
        }
    }
}

struct TransformDetailView: View {
    @State var configuration = PrismConfiguration(extrusion: 60)

    var body: some View {
        PrismCanvas(tilt: configuration.tilt) {
            TransformPrismView(configuration: $configuration)
        }
        .navigationTitle("Transform")
    }
}

struct TransformPrismView: View {
    @Binding var configuration: PrismConfiguration
    @State var displayedWidths: [DisplayedWidth] = [
        .init(width: 1),
        .init(width: 2),
        .init(width: 3),
        .init(width: 4),
        .init(width: 5),
    ]

    @State var expanded = true
    @State var showingWidths = true

    var body: some View {
        Button {
            expanded.toggle()
            withAnimation {
                showingWidths.toggle()
            }
        } label: {
            PrismView(configuration: configuration) {
                Color.purple
                    .overlay {
                        Text("Tap me")
                            .foregroundColor(.white)
                    }
            } left: {
                Color.purple.brightness(-0.1).opacity(0.75)
            } right: {
                Color.purple.brightness(-0.2).opacity(0.5)
            }
            .background(
                ZStack {
                    ForEach(displayedWidths) { displayedWidth in
                        Rectangle()
                            .stroke(Color.purple, lineWidth: CGFloat(5 - displayedWidth.width))
                            .padding(-CGFloat(displayedWidth.width * 15))
                    }
                }
                .opacity(showingWidths ? 1 : 0)
            )
        }
        .onChange(of: expanded) { newValue in
            withAnimation(.spring()) {
                if newValue {
                    configuration.tilt = 0.3
                    configuration.extrusion = 60
                    configuration.shadowOpacity = 0.25
                } else {
                    configuration.tilt = 0
                    configuration.extrusion = 0
                    configuration.shadowOpacity = 0
                }
            }
        }
        .buttonStyle(.scaling)
    }
}

struct DisplayedWidth: Identifiable {
    let id = UUID()
    var width: CGFloat
}
