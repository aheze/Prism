//
//  Models.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct DisplayedPrismConfiguration: Identifiable {
    let id = UUID()
    var configuration: PrismConfiguration
}
