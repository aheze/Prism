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
    
    var body: some View {
        VStack {
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
                    color: .blue
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(.blue)
            
            sliders
        }
        .padding()
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
            Slider(value: $value, in: range)
        }
    }
}
