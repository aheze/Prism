//
//  PrismCanvas.swift
//  Prism
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    

import SwiftUI

struct PrismCanvas<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        content
    }
}
