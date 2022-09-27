//
//  ViewModel.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

class ViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var configuration = PrismConfiguration()
}
