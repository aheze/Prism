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
    @State var tilt = CGFloat(0)
    @State var size = CGSize(width: 100, height: 100)
    @State var extrusion = CGFloat(20)
    
    @State var levitation = CGFloat(0)
    @State var shadowColor = Color.black
    @State var shadowOpacity = CGFloat(0.25)
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Prism")
                .tracking(20)
                .offset(x: 10)
                .textCase(.uppercase)
                .font(.system(.largeTitle).weight(.ultraLight))
            
            PrismCanvas(tilt: tilt) {
                PrismColorView(
                    tilt: tilt,
                    size: size,
                    extrusion: extrusion,
                    levitation: levitation,
                    shadowColor: shadowColor,
                    shadowOpacity: shadowOpacity,
                    color: .blue
                )
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
            
            sliders
        }
        .padding(.top, 20)
    }
    
    var sliders: some View {
        let width = Binding {
            size.width
        } set: { newValue in
            size.width = newValue
        }
        
        let height = Binding {
            size.height
        } set: { newValue in
            size.height = newValue
        }

        return Grid {
            ExampleSliderView(title: "Tilt", value: $tilt, range: 0 ... 1)
            ExampleSliderView(title: "Width", value: width, range: 0 ... 200)
            ExampleSliderView(title: "Height", value: height, range: 0 ... 200)
            ExampleSliderView(title: "Extrusion", value: $extrusion, range: 0 ... 100)
            ExampleSliderView(title: "Levitation", value: $levitation, range: 0 ... 200)
            ExampleColorView(title: "Shadow Color", value: $shadowColor)
            ExampleSliderView(title: "Shadow Opacity", value: $shadowOpacity, range: 0 ... 1)
        }
        .padding(16)
        .background(UIColor.secondarySystemBackground.color)
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
                .padding(.vertical, 8)
                
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
                .padding(.vertical, 8)
            
            ColorPicker(title, selection: $value)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
