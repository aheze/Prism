//
//  ContentView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct ContentView: View {
    @StateObject var model = ViewModel()

    var body: some View {
        NavigationStack(path: $model.path) {
            ScrollView {
                VStack(spacing: 30) {
                    header

                    GalleryView(model: model)
                }
            }
            .background(UIColor.secondarySystemBackground.color)
        }
    }

    var header: some View {
        VStack(spacing: 20) {
            Text("Prism")
                .tracking(20)
                .offset(x: 10)
                .textCase(.uppercase)
                .font(.system(.largeTitle).weight(.ultraLight))

            HStack(spacing: 14) {
                ExampleLinkButton(title: "GitHub", url: "https://github.com/aheze/Prism")
                ExampleLinkButton(title: "Twitter", url: "https://twitter.com/aheze0")
            }
        }
        .padding(.top, 36)
    }
}

struct ExampleSliderView: View {
    var title: String
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat>
    var body: some View {
        GridRow {
            Text(title)
                .gridColumnAlignment(.leading)
                .padding(.vertical, 6)

            Slider(value: $value, in: range)
        }
    }
}

struct ExampleColorView: View {
    var title: String
    @Binding var value: Color
    var body: some View {
        GridRow {
            Text(title)
                .gridColumnAlignment(.leading)
                .padding(.vertical, 6)

            Color.clear
                .gridCellUnsizedAxes(.vertical)
                .overlay(alignment: .leading) {
                    ColorPicker(title, selection: $value)
                        .labelsHidden()
                }
        }
    }
}

struct ExampleLinkButton: View {
    var title: String
    var url: String

    var body: some View {
        Button {
            let url = URL(string: url)!
            UIApplication.shared.open(url)
        } label: {
            Text(title)
                .foregroundColor(.blue)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(.blue.opacity(0.1))
                .cornerRadius(12)
        }
    }
}
