//
//  DetailView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    
import Prism
import SwiftUI

struct DetailView<Content: View, Controls: View>: View {
    @ViewBuilder var content: (PrismConfiguration) -> Content
    @ViewBuilder var controls: Controls
    
    @State var configuration = PrismConfiguration()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        let layout = verticalSizeClass == .regular
            ? AnyLayout(VStackLayout(spacing: 30))
            : AnyLayout(HStackLayout(spacing: 20))
        
        layout {
            PrismCanvas(tilt: configuration.tilt) {
                content(configuration)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(UIColor.systemBackground.color)
            .cornerRadius(16)
            .shadow(
                color: .black.opacity(0.25),
                radius: 10,
                x: 0,
                y: 2
            )
            .padding(.horizontal, 20)
            .padding(.top, 12)
            
            VStack {
                Grid {
                    controls
                        .fontWeight(.semibold)
                    Divider()
                    sliders
                    
                    GridRow {
                        Button("Randomize") {
                            randomize()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Color.clear
                            .gridCellUnsizedAxes(.horizontal)
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(UIColor.secondarySystemBackground.color)
        }
    }
    
    var sliders: some View {
        let width = Binding {
            configuration.size.width
        } set: { newValue in
            configuration.size.width = newValue
        }
        
        let height = Binding {
            configuration.size.height
        } set: { newValue in
            configuration.size.height = newValue
        }

        return Group {
            ExampleSliderView(title: "Tilt", value: $configuration.tilt, range: 0 ... 1)
            ExampleSliderView(title: "Width", value: width, range: 0 ... 200)
            ExampleSliderView(title: "Height", value: height, range: 0 ... 200)
            ExampleSliderView(title: "Extrusion", value: $configuration.extrusion, range: 0 ... 100)
            ExampleSliderView(title: "Levitation", value: $configuration.levitation, range: 0 ... 100)
            ExampleColorView(title: "Shadow Color", value: $configuration.shadowColor)
            ExampleSliderView(title: "Shadow Opacity", value: $configuration.shadowOpacity, range: 0 ... 1)
        }
    }
    
    func randomize() {
        withAnimation(.spring()) {
            configuration.tilt = CGFloat.random(in: 0 ..< 1)
            configuration.size.height = CGFloat.random(in: 0 ..< 200)
            configuration.size.width = CGFloat.random(in: 0 ..< 200)
            configuration.extrusion = CGFloat.random(in: 0 ..< 100)
            configuration.levitation = CGFloat.random(in: 0 ..< 100)
            configuration.shadowColor = UIColor.random.color
            configuration.shadowOpacity = CGFloat.random(in: 0 ..< 1)
        }
    }
}
