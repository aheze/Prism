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
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Prism")
                .tracking(20)
                
                .offset(x: 10)
                .textCase(.uppercase)
                .font(.system(.largeTitle).weight(.ultraLight))
            
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
            
            VStack(spacing: 0) {
                controls
                Divider()
                sliders
            }
        }
        .padding(.top, 20)
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

        return Grid {
            ExampleSliderView(title: "Tilt", value: $configuration.tilt, range: 0 ... 1)
            ExampleSliderView(title: "Width", value: width, range: 0 ... 200)
            ExampleSliderView(title: "Height", value: height, range: 0 ... 200)
            ExampleSliderView(title: "Extrusion", value: $configuration.extrusion, range: 0 ... 100)
            ExampleSliderView(title: "Levitation", value: $configuration.levitation, range: 0 ... 200)
            ExampleColorView(title: "Shadow Color", value: $configuration.shadowColor)
            ExampleSliderView(title: "Shadow Opacity", value: $configuration.shadowOpacity, range: 0 ... 1)
        }
        .padding(16)
        .background(UIColor.secondarySystemBackground.color)
    }
}
