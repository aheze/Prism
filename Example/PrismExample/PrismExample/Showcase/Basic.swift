//
//  Basic.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct BasicGalleryView: View {
    @ObservedObject var model: ViewModel
    @State var configuration = PrismConfiguration(extrusion: 60)

    var body: some View {
        GalleryCardView(model: model, kind: .basic) {
            PrismCanvas(tilt: configuration.tilt) {
                PrismView(configuration: configuration) {
                    Color.blue
                        .overlay {
                            VStack(spacing: 12) {
                                Image(systemName: "cube")
                                    .font(.largeTitle)

                                Text("Prism")
                                    .textCase(.uppercase)
                            }
                            .foregroundColor(.white)
                        }
                } left: {
                    Color.red
                } right: {
                    Color.green
                }
            }
            .frame(minHeight: 240)
            .offset(y: 20)
        }
    }
}

struct BasicDetailView: View {
    @State var configuration = PrismConfiguration(extrusion: 60)

    var body: some View {
        PrismCanvas(tilt: configuration.tilt) {
            PrismView(configuration: configuration) {
                Color.blue
                    .overlay {
                        VStack(spacing: 12) {
                            Image(systemName: "cube")
                                .font(.largeTitle)

                            Text("Prism")
                                .textCase(.uppercase)
                        }
                        .foregroundColor(.white)
                    }
            } left: {
                Color.red
            } right: {
                Color.green
            }
        }
        .navigationTitle("Basic")
    }
}
