//
//  Island.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 10/20/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct IslandGalleryView: View {
    @ObservedObject var model: ViewModel
    @State var tilt = CGFloat(0.4)
    @State var scale = CGFloat(0.6)
    @State var offset = CGFloat(20)

    var body: some View {
        GalleryCardView(model: model, kind: .island) {
            Color.clear.overlay {
                IslandView(tilt: tilt, scale: scale, offset: offset)
                    .frame(width: 400, height: 400)
                    .scaleEffect(0.46)
            }
            .allowsHitTesting(false)
            .frame(minHeight: 240)
            .offset(y: 20)
        }
    }
}

struct IslandDetailView: View {
    @State var tilt = CGFloat(0.4)
    @State var scale = CGFloat(0.6)
    @State var offset = CGFloat(20)

    @State var savedTranslation = CGFloat(0)
    @GestureState var translation = CGFloat(0)
    @State var translationStore = CGFloat(0) /// backup store since `GestureState` auto-resets to 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome!")
                .font(.system(.title, design: .serif, weight: .light))

            IslandView(tilt: tilt, scale: scale, offset: offset)
                .frame(width: 400, height: 400)
                .background(UIColor.systemBackground.color)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 2)

            VStack(spacing: 14) {
                Text("Drag horizontally to move.")

                Text("Try tapping the boat!")
            }
            .font(.system(.title2, design: .serif, weight: .light))
            .foregroundColor(UIColor.secondaryLabel.color)

            Spacer()
        }
        .padding(.top, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            UIColor.systemBackground.color.ignoresSafeArea()
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($translation) { value, state, transaction in
                    state = value.translation.width

                    let totalTranslation = savedTranslation + translation
                    let adjustedTranslation = -totalTranslation / 100
                    var adjustedTilt = 0.4 + adjustedTranslation
                    adjustedTilt = min(max(0.0001, adjustedTilt), 2)

                    DispatchQueue.main.async {
                        tilt = adjustedTilt
                        scale = 0.6 - adjustedTranslation / 8
                        offset = 20 - adjustedTranslation / 12

                        self.translationStore = value.translation.width
                    }
                }
                .onEnded { value in
                    savedTranslation += translationStore
                }
        )
        .navigationTitle("Island")
    }
}

struct IslandView: View {
    var tilt: CGFloat
    var scale: CGFloat
    var offset: CGFloat

    @State var boatPressed = false

    let numberOfBars = 6
    let sidewalkLength = CGFloat(30)
    let sidewalkInset = CGFloat(10)
    let wallRightBrightness = CGFloat(-0.4)

    var body: some View {
        PrismCanvas(tilt: tilt) {
            PrismView(tilt: tilt, size: .init(width: 400, height: 400), extrusion: 10, shadowOpacity: 0.15) {
                content
            } left: {
                Color(hex: 0xE19D00)
            } right: {
                Color(hex: 0xE19D00).brightness(-0.2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaleEffect(scale)
        .offset(y: offset)
        .drawingGroup() /// makes it much smoother
    }
}

extension IslandView {
    var content: some View {
        VStack(spacing: 0) {
            ocean

            ground
        }
        .background(Color(hex: 0x005A7C)) /// seabed
    }

    var ocean: some View {
        PrismView(tilt: tilt, size: .init(width: 400, height: 135), extrusion: 40) {
            Color(hex: 0x01A2FF).opacity(0.5)
                .overlay {
                    Button {
                        withAnimation(.spring(response: 0.9, dampingFraction: 0.5, blendDuration: 1)) {
                            boatPressed.toggle()
                        }
                    } label: {
                        boat
                            .offset(x: boatPressed ? 80 : -30, y: -10)
                    }
                    .buttonStyle(.scaling)
                }
        } left: {
            Color(hex: 0x01A2FF).opacity(0.75)
        } right: {
            Color(hex: 0x01A2FF).opacity(0.75)
        }
    }

    var ground: some View {
        PrismView(tilt: tilt, size: .init(width: 400, height: 265), extrusion: 50) {
            Color.clear.overlay(alignment: .top) {
                surface
            }
            .clipped()
            .overlay {
                VStack(spacing: 0) {
                    PrismView(tilt: tilt, size: .init(width: 400, height: 25), extrusion: 3) {
                        Color(hex: 0xB5C0C7)
                            .overlay {
                                coastFence
                            }
                    } left: {
                        Color(hex: 0xB5C0C7).brightness(-0.1)
                    } right: {
                        Color(hex: 0xB5C0C7).brightness(-0.2)
                    }
                    .frame(height: 65, alignment: .top)

                    HStack(spacing: 0) {
                        buildings

                        /// middle separator
                        Color.clear
                            .frame(width: 60)
                            .overlay {
                                Button {
                                    if let url = URL(string: "https://twitter.com/aheze0") {
                                        UIApplication.shared.open(url)
                                    }
                                } label: {
                                    Text("PRISM")
                                        .font(.system(size: 28, weight: .ultraLight, design: .serif))
                                        .tracking(8)
                                        .foregroundColor(Color.pink)
                                        .shadow(
                                            color: Color.black.opacity(0.25),
                                            radius: 6,
                                            x: 0,
                                            y: 0
                                        )
                                }
                                .buttonStyle(.scaling)
                                .fixedSize()
                                .rotationEffect(.degrees(-90))
                                .offset(y: 20)
                            }

                        park
                    }
                }
            }
            .overlay {
                PrismView(tilt: tilt, size: .init(width: 90, height: 1), extrusion: 170, levitation: 30) {
                    Color.clear
                } left: {
                    PinShape()
                        .fill(Color.red)
                        .shadow(
                            color: Color.black.opacity(0.5),
                            radius: 16,
                            x: 0,
                            y: 24
                        )
                        .overlay(alignment: .top) {
                            Circle()
                                .fill(Color.red)
                                .brightness(-0.2)
                                .overlay {
                                    Image(systemName: "plus")
                                        .font(.system(size: 42, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                .padding(10)
                        }
                } right: {
                    Color.clear
                }
                .offset(x: 35)
            }
        } left: {
            Color(hex: 0xB5C0C7).brightness(-0.1)
                .overlay {
                    Text("Made with SwiftUI")
                        .font(.system(size: 24, weight: .semibold, design: .serif))
                        .opacity(0.25)
                }

        } right: {
            Color(hex: 0xB5C0C7).brightness(-0.2)
        }
    }

    var buildings: some View {
        PrismView(tilt: tilt, size: .init(width: 200, height: 200), extrusion: 7) {
            Color(hex: 0xF7F7F7) /// floor
                .overlay {
                    sidewalk
                }
                .overlay {
                    /// inset: 30 + 10, so height = 160
                    VStack(spacing: 0) {
                        hut

                        Color.clear.frame(height: 10)

                        glassBuilding
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 20)

                        Color.clear.frame(height: 10)

                        /// 160 - 60 = 100 width
                        HStack(spacing: 20) {
                            yellowBoard

                            redTower
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 40)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, sidewalkLength + sidewalkInset)
                    .padding(.trailing, sidewalkLength + sidewalkInset)
                }
        } left: {
            Color(hex: 0xF7F7F7).brightness(-0.1)
        } right: {
            Color(hex: 0xD5D5D5)
        }
    }

    var glassBuilding: some View {
        PrismView(tilt: tilt, size: .init(width: 130, height: 50), extrusion: 70) {
            Color(hex: 0x8D9C9F)
                .overlay {
                    roof
                }
        } left: {
            Color(hex: 0x007DBD).brightness(-0.1).opacity(0.5)
                .overlay {
                    HStack(spacing: 0) {
                        ForEach(0 ..< 6) { _ in
                            Rectangle()
                                .stroke(Color(hex: 0xFFFFFF), lineWidth: 2)
                        }
                    }
                }
                .clipped()
        } right: {
            Color(hex: 0x007DBD).brightness(-0.2).opacity(0.7)
        }
    }

    var hut: some View {
        PrismView(tilt: tilt, size: .init(width: 100, height: 60), extrusion: 55) {
            Color(hex: 0xAB7900)
                .overlay(alignment: .leading) {
                    PrismView(tilt: tilt, size: .init(width: 100 + 15, height: 60 + 10), extrusion: 5) {
                        HStack(spacing: 0) {
                            ForEach(0 ..< 12) { index in
                                let isEven = index % 2 == 0

                                Color(hex: 0xAB7900)
                                    .brightness(isEven ? 0 : -0.1)
                            }
                        }
                    } left: {
                        Color(hex: 0xAB7900).brightness(-0.1)
                    } right: {
                        Color(hex: 0xAB7900).brightness(-0.2)
                    }
                    .offset(x: -5)
                }
        } left: {
            Color(hex: 0xAB7900).brightness(-0.1)
        } right: {
            Color(hex: 0xAB7900).brightness(-0.2)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    var boat: some View {
        var base: some View {
            HStack(spacing: 0) {
                PrismView(tilt: tilt, size: .init(width: 10, height: 30), extrusion: 15, levitation: -5) {
                    Color(hex: 0x7C5A00)
                } left: {
                    Color(hex: 0x7C5A00).brightness(-0.1)
                } right: {
                    Color(hex: 0x7C5A00).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 100, height: 40), extrusion: 20, levitation: -10) {
                    Color(hex: 0x7C5A00)
                } left: {
                    Color(hex: 0x7C5A00).brightness(-0.1)
                } right: {
                    Color(hex: 0x7C5A00).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 15, height: 30), extrusion: 15, levitation: -5) {
                    Color(hex: 0x7C5A00)
                } left: {
                    Color(hex: 0x7C5A00).brightness(-0.1)
                } right: {
                    Color(hex: 0x7C5A00).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 18, height: 15), extrusion: 15) {
                    Color(hex: 0x7C5A00)
                } left: {
                    Color(hex: 0x7C5A00).brightness(-0.1)
                } right: {
                    Color(hex: 0x7C5A00).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 35, height: 6), extrusion: 7, levitation: 8) {
                    LinearGradient(
                        colors: [Color(hex: 0x7C5A00), UIColor(hex: 0x7C5A00).adjust(by: 0.3).color],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                } left: {
                    Color(hex: 0x7C5A00).brightness(-0.1)
                } right: {
                    Color(hex: 0x7C5A00).brightness(-0.2)
                }
            }
        }

        var deck: some View {
            HStack(spacing: 0) {
                PrismView(tilt: tilt, size: .init(width: 5, height: 20), extrusion: 5, levitation: 10) {
                    Color(hex: 0x5F4000)
                } left: {
                    Color(hex: 0x5F4000).brightness(-0.1)
                } right: {
                    Color(hex: 0x5F4000).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 90, height: 30), extrusion: 5, levitation: 10) {
                    Color(hex: 0x5F4000)
                } left: {
                    Color(hex: 0x5F4000).brightness(-0.1)
                } right: {
                    Color(hex: 0x5F4000).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 5, height: 20), extrusion: 5, levitation: 10) {
                    Color(hex: 0x5F4000)
                } left: {
                    Color(hex: 0x5F4000).brightness(-0.1)
                } right: {
                    Color(hex: 0x5F4000).brightness(-0.2)
                }
                PrismView(tilt: tilt, size: .init(width: 13, height: 11), extrusion: 5, levitation: 10) {
                    Color(hex: 0x5F4000)
                } left: {
                    Color(hex: 0x5F4000).brightness(-0.1)
                } right: {
                    Color(hex: 0x5F4000).brightness(-0.2)
                }
            }
        }

        var sails: some View {
            HStack(spacing: 0) {
                PrismView(tilt: tilt, size: .init(width: 16, height: 1), extrusion: 42, levitation: 25) {
                    Color.clear
                } left: {
                    Color.clear
                        .overlay(alignment: .trailing) {
                            LineShape(slantUp: true)
                                .stroke(Color.black, lineWidth: 2)
                                .frame(width: 15)
                        }
                } right: {
                    Color.clear
                }

                PrismView(tilt: tilt, size: .init(width: 4, height: 4), extrusion: 42, levitation: 25) {
                    Color(hex: 0x936500)
                } left: {
                    Color(hex: 0x936500).brightness(-0.05)
                } right: {
                    Color(hex: 0x936500).brightness(-0.1)
                }

                PrismView(tilt: tilt, size: .init(width: 3, height: 20), extrusion: 18, levitation: 40) {
                    Color.white
                        .overlay {
                            PrismView(tilt: tilt, size: .init(width: 3, height: 30), extrusion: 18, levitation: 10) {
                                Color.white
                            } left: {
                                Color.white.brightness(-0.1)
                            } right: {
                                Color.white.brightness(-0.2)
                            }
                        }
                } left: {
                    Color.white.brightness(-0.05)
                } right: {
                    Color.white.brightness(-0.1)
                }

                PrismView(tilt: tilt, size: .init(width: 24, height: 1), extrusion: 60, levitation: 25) {
                    Color.clear
                } left: {
                    Color.clear
                        .overlay(alignment: .trailing) {
                            LineShape(slantUp: true)
                                .stroke(Color.black, lineWidth: 2)
                                .frame(width: 15)
                        }
                } right: {
                    Color.clear
                }

                PrismView(tilt: tilt, size: .init(width: 4, height: 4), extrusion: 60, levitation: 25) {
                    Color(hex: 0x936500)
                } left: {
                    Color(hex: 0x936500).brightness(-0.05)
                } right: {
                    Color(hex: 0x936500).brightness(-0.1)
                }
                PrismView(tilt: tilt, size: .init(width: 3, height: 30), extrusion: 30, levitation: 40) {
                    Color.white
                        .overlay {
                            PrismView(tilt: tilt, size: .init(width: 3, height: 30), extrusion: 30, levitation: 10) {
                                Color.white
                            } left: {
                                Color.white.brightness(-0.1)
                            } right: {
                                Color.white.brightness(-0.2)
                            }
                        }
                } left: {
                    Color.white.brightness(-0.1)
                } right: {
                    Color.white.brightness(-0.2)
                }

                PrismView(tilt: tilt, size: .init(width: 24, height: 1), extrusion: 35, levitation: 25) {
                    Color.clear
                } left: {
                    Color.clear
                        .overlay(alignment: .trailing) {
                            LineShape(slantUp: true)
                                .stroke(Color.black, lineWidth: 2)
                                .frame(width: 15)
                        }
                } right: {
                    Color.clear
                }

                PrismView(tilt: tilt, size: .init(width: 4, height: 4), extrusion: 35, levitation: 25) {
                    Color(hex: 0x936500)
                } left: {
                    Color(hex: 0x936500).brightness(-0.05)
                } right: {
                    Color(hex: 0x936500).brightness(-0.1)
                }
                PrismView(tilt: tilt, size: .init(width: 3, height: 20), extrusion: 25, levitation: 40) {
                    Color.white
                } left: {
                    Color.white.brightness(-0.05)
                } right: {
                    Color.white.brightness(-0.1)
                }
            }
        }

        return ZStack(alignment: .leading) {
            base

            deck
                .padding(.leading, 5)

            /// ivory
            PrismView(tilt: tilt, size: .init(width: 85, height: 10), extrusion: 5, levitation: 15) {
                LinearGradient(
                    colors: [Color(hex: 0xC6BDAD), UIColor(hex: 0xC6BDAD).adjust(by: 0.3).color],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            } left: {
                Color(hex: 0xC6BDAD).brightness(-0.1)
            } right: {
                Color(hex: 0xC6BDAD).brightness(-0.2)
            }
            .padding(.leading, 15)

            sails
                .padding(.leading, 15)
        }
    }

    /// tiles
    var surface: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 30) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< 30) { column in

                        let brightness: CGFloat = {
                            let patternLength = 8
                            let r = row % patternLength
                            let c = column % patternLength

                            var brightness = CGFloat(0)
                            if r % 2 == 0 {
                                brightness -= 0.05
                            }

                            if r % 4 == 0 {
                                brightness -= 0.025
                            }

                            if c % 3 == 0, r == 3 {
                                brightness -= 0.05
                            }

                            if c % 3 == 0, r == 6 {
                                brightness -= 0.05
                            }

                            if c % 2 == 0, r == 7 {
                                brightness -= 0.025
                            }

                            if c % 2 == 1, r == 4 {
                                brightness -= 0.05
                            }

                            if c == 1, r == 2 {
                                brightness -= 0.05
                            }

                            if c == 4, r == 0 {
                                brightness -= 0.05
                            }
                            if c % 3 != 0, r == 1 {
                                brightness -= 0.025
                            }

                            if c % 4 != 0, r == 5 {
                                brightness -= 0.05
                            }

                            return brightness
                        }()

                        Color(hex: 0xDDE0E2)
                            .aspectRatio(1, contentMode: .fill)
                            .brightness(brightness)
                    }
                }
            }
        }
    }

    var park: some View {
        var tile: some View {
            PrismView(tilt: tilt, size: .init(width: 18, height: 18), extrusion: 4, shadowOpacity: 0.08) {
                Color(hex: 0xE2E2E2)
            } left: {
                Color(hex: 0xE2E2E2).brightness(-0.1)
            } right: {
                Color(hex: 0xE2E2E2).brightness(-0.2)
            }
        }

        var green: some View {
            PrismView(tilt: tilt, size: .init(width: 120, height: 180), extrusion: 3) {
                Color(hex: 0x00A30D)
                    .overlay {
                        ZStack(alignment: .topLeading) {
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 14, y: 40).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 38, y: 46).brightness(-0.05).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 60, y: 62).brightness(-0.1).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 84, y: 78).brightness(-0.1).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 88, y: 106).brightness(-0.05).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 90, y: 134).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 96, y: 160).brightness(-0.05).opacity(0.9)
                            Color(hex: 0xBFAA00).frame(width: 45, height: 45).position(x: 107, y: 186).brightness(-0.1).opacity(0.9)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .overlay {
                        ZStack(alignment: .topLeading) {
                            tile.position(x: 14, y: 40)
                            tile.position(x: 38, y: 46).brightness(-0.05)
                            tile.position(x: 60, y: 62).brightness(-0.1)
                            tile.position(x: 84, y: 78).brightness(-0.1)
                            tile.position(x: 88, y: 106).brightness(-0.05)
                            tile.position(x: 90, y: 134)
                            tile.position(x: 96, y: 160).brightness(-0.05)
                            tile.position(x: 107, y: 186).brightness(-0.1)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .clipped()
                    .overlay {
                        ZStack(alignment: .topLeading) {
                            PrismView(tilt: tilt, size: .init(width: 26, height: 26), extrusion: 14, shadowColor: Color.white) {
                                Color(hex: 0x008F27)
                            } left: {
                                Color(hex: 0x008F27).brightness(-0.1)
                            } right: {
                                Color(hex: 0x008F27).brightness(-0.2)
                            }
                            .position(x: 94, y: 29)

                            PrismView(tilt: tilt, size: .init(width: 20, height: 20), extrusion: 8, shadowColor: Color.white) {
                                Color(hex: 0x3F7C00)
                            } left: {
                                Color(hex: 0x3F7C00).brightness(-0.1)
                            } right: {
                                Color(hex: 0x3F7C00).brightness(-0.2)
                            }
                            .position(x: 26, y: 109)

                            PrismView(tilt: tilt, size: .init(width: 26, height: 26), extrusion: 14, shadowColor: Color.white) {
                                Color(hex: 0x709300)
                            } left: {
                                Color(hex: 0x709300).brightness(-0.1)
                            } right: {
                                Color(hex: 0x709300).brightness(-0.2)
                            }
                            .position(x: 44, y: 146)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
            } left: {
                Color(hex: 0x00A30D).brightness(-0.1)
            } right: {
                Color(hex: 0x00A30D).brightness(-0.2)
            }
        }

        return VStack(spacing: 0) {
            Color(hex: 0x8D5F00)
                .frame(height: 20)
                .overlay {
                    ZStack(alignment: .topLeading) {
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: -5, y: 0)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 10, y: 8)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 40, y: 12)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 48, y: 6)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 52, y: 0)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 90, y: 12)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 120, y: 4)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 140, y: 16)
                        Color.black.opacity(0.12).frame(width: 45, height: 15).position(x: 155, y: 6)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .clipped()

            HStack(spacing: 0) {
                Color(hex: 0x8D5F00)
                    .frame(width: 20)
                    .overlay {
                        ZStack(alignment: .topLeading) {
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 0, y: -5)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 8, y: 10)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 12, y: 40)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 6, y: 48)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 0, y: 52)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 12, y: 90)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 4, y: 120)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 16, y: 140)
                            Color.black.opacity(0.12).frame(width: 15, height: 45).position(x: 6, y: 155)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .clipped()

                green
            }
        }
    }

    // width: 60, height: 20
    var yellowBoard: some View {
        func wall(levitation: CGFloat) -> some View {
            PrismView(tilt: tilt, size: .init(width: 4, height: 12), extrusion: 20, levitation: levitation) {
                UIColor(hex: 0x703E1A).color
            } left: {
                UIColor(hex: 0x703E1A).color.brightness(-0.1)
            } right: {
                UIColor(hex: 0x703E1A).color.brightness(-0.2)
            }
        }

        func walls(levitation: CGFloat) -> some View {
            HStack {
                wall(levitation: levitation)

                Spacer()

                wall(levitation: levitation)
            }
            .padding(.horizontal, 6)
        }

        func platform(levitation: CGFloat) -> some View {
            PrismView(tilt: tilt, size: .init(width: 60, height: 20), extrusion: 4, levitation: levitation) {
                UIColor(hex: 0xE3B400).color
            } left: {
                UIColor(hex: 0xE3B400).color.brightness(-0.1)
            } right: {
                UIColor(hex: 0xE3B400).color.brightness(-0.2)
            }
        }

        return ZStack {
            walls(levitation: 0)
                .overlay {
                    platform(levitation: 20)
                }
            walls(levitation: 24)
                .overlay {
                    platform(levitation: 44)
                }
        }
        .padding(.bottom, 10)
    }

    var redTower: some View {
        let baseColor = UIColor(hex: 0xD66D31)

        return PrismView(tilt: tilt, size: .init(width: 30, height: 30), extrusion: 20) {
            baseColor.color
                .overlay {
                    PrismView(tilt: tilt, size: .init(width: 25, height: 25), extrusion: 20) {
                        baseColor.offset(by: 0.02).color
                            .overlay {
                                PrismView(tilt: tilt, size: .init(width: 20, height: 20), extrusion: 20) {
                                    baseColor.offset(by: 0.04).color
                                        .overlay {
                                            PrismView(tilt: tilt, size: .init(width: 12, height: 12), extrusion: 20) {
                                                baseColor.offset(by: 0.05).color
                                                    .overlay {
                                                        PrismView(tilt: tilt, size: .init(width: 3, height: 3), extrusion: 30) {
                                                            Color.white
                                                        } left: {
                                                            Color.white.brightness(-0.1)
                                                        } right: {
                                                            Color.white.brightness(-0.2)
                                                        }
                                                    }
                                            } left: {
                                                baseColor.offset(by: 0.05).color.brightness(-0.1)
                                            } right: {
                                                baseColor.offset(by: 0.05).color.brightness(-0.2)
                                            }
                                        }
                                } left: {
                                    baseColor.offset(by: 0.04).color.brightness(-0.1)
                                } right: {
                                    baseColor.offset(by: 0.04).color.brightness(-0.2)
                                }
                            }
                    } left: {
                        baseColor.offset(by: 0.02).color.brightness(-0.1)
                    } right: {
                        baseColor.offset(by: 0.02).color.brightness(-0.2)
                    }
                }
        } left: {
            baseColor.color.brightness(-0.1)
        } right: {
            baseColor.color.brightness(-0.2)
        }
    }

    var coastFence: some View {
        HStack {
            ForEach(0 ..< numberOfBars) { index in
                PrismView(tilt: tilt, size: .init(width: 10, height: 10), extrusion: 6) {
                    Color(hex: 0x8A751B)
                        .overlay {
                            PrismView(tilt: tilt, size: .init(width: 5, height: 5), extrusion: 14) {
                                Color(hex: 0x763800)
                            } left: {
                                Color(hex: 0x763800).brightness(-0.1)
                            } right: {
                                Color(hex: 0x763800).brightness(-0.2)
                            }
                        }
                } left: {
                    Color(hex: 0x8A751B).brightness(-0.1)
                } right: {
                    Color(hex: 0x8A751B).brightness(-0.2)
                }

                if index < numberOfBars - 1 {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 16)
        .overlay {
            PrismView(tilt: tilt, size: .init(width: 400, height: 6), extrusion: 5, levitation: 20) {
                Color(hex: 0x976B00)
            } left: {
                Color(hex: 0x976B00).brightness(-0.1)
            } right: {
                Color(hex: 0x976B00).brightness(-0.2)
            }
        }
    }

    // width: 130, height: 50
    var roof: some View {
        VStack(spacing: 0) {
            PrismView(tilt: tilt, size: .init(width: 130, height: 4), extrusion: 9) {
                Color(hex: 0x9A9A9A)
            } left: {
                Color(hex: 0x9A9A9A).brightness(-0.1)
            } right: {
                Color(hex: 0x9A9A9A).brightness(wallRightBrightness)
            }

            HStack {
                PrismView(tilt: tilt, size: .init(width: 4, height: 50 - 8), extrusion: 9) {
                    Color(hex: 0x9A9A9A)
                } left: {
                    Color(hex: 0x9A9A9A).brightness(-0.1)
                } right: {
                    Color(hex: 0x9A9A9A).brightness(wallRightBrightness)
                }

                Spacer()

                PrismView(tilt: tilt, size: .init(width: 4, height: 50 - 8), extrusion: 9) {
                    Color(hex: 0x9A9A9A)
                } left: {
                    Color(hex: 0x9A9A9A).brightness(-0.1)
                } right: {
                    Color(hex: 0x9A9A9A).brightness(wallRightBrightness)
                }
            }

            PrismView(tilt: tilt, size: .init(width: 130, height: 4), extrusion: 9) {
                Color(hex: 0x9A9A9A)
            } left: {
                Color(hex: 0x9A9A9A).brightness(-0.1)
            } right: {
                Color(hex: 0x9A9A9A).brightness(wallRightBrightness)
            }
        }
    }

    var sidewalk: some View {
        VStack(spacing: 0) {
            Color(hex: 0xF1F1F1)
                .frame(height: sidewalkLength)
                .overlay(alignment: .trailing) {
                    let columns = Int(200 / sidewalkLength) + 1

                    HStack(spacing: 0) {
                        ForEach(0 ..< columns) { _ in
                            Rectangle()
                                .stroke(Color(hex: 0xD5D5D5), lineWidth: 3)
                                .aspectRatio(1, contentMode: .fill)
                        }
                    }
                }
                .clipped()

            HStack(spacing: 0) {
                Spacer()

                Color(hex: 0xF1F1F1)
                    .frame(width: sidewalkLength)
                    .overlay(alignment: .top) {
                        let rows = Int(200 / sidewalkLength) + 1

                        VStack(spacing: 0) {
                            ForEach(0 ..< rows) { _ in
                                Rectangle()
                                    .stroke(Color(hex: 0xD5D5D5), lineWidth: 3)
                                    .aspectRatio(1, contentMode: .fill)
                            }
                        }
                    }
                    .clipped()
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct LineShape: Shape {
    var slantUp = true
    func path(in rect: CGRect) -> Path {
        Path { path in
            if slantUp {
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            } else {
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            }
        }
    }
}

/// from https://github.com/dchakarov/DropPin
struct PinShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let radius = rect.width / 2

            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addCurve(
                to: CGPoint(x: rect.minX, y: radius),
                control1: CGPoint(x: rect.midX, y: rect.maxY),
                control2: CGPoint(x: rect.minX, y: radius + rect.height / 4)
            )
            path.addArc(
                center: CGPoint(x: rect.midX, y: radius),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(0),
                clockwise: false
            )

            path.addCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control1: CGPoint(x: rect.maxX, y: radius + rect.height / 4),
                control2: CGPoint(x: rect.midX, y: rect.maxY)
            )
        }
    }
}
