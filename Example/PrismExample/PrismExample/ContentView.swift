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
                    Text("Prism")
                        .tracking(20)
                        .offset(x: 10)
                        .textCase(.uppercase)
                        .font(.system(.largeTitle).weight(.ultraLight))
                    
                    GalleryView(model: model)
                }
                .padding(.top, 20)
            }
            .background(UIColor.secondarySystemBackground.color)
        }
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
