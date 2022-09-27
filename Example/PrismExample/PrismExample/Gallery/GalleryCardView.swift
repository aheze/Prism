//
//  GalleryCardView.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Prism
import SwiftUI

struct GalleryCardView<Content: View>: View {
    @ObservedObject var model: ViewModel
    var kind: TemplateKind
    @ViewBuilder var content: Content

    var body: some View {
        Button {
            model.path.append(kind)
        } label: {
            VStack(spacing: 0) {
                PrismCanvas(configuration: model.configuration) {
                    content
                }
                .frame(minHeight: 200)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                Divider()

                HStack {
                    Text(kind.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 16)

                    Image(systemName: "chevron.right")
                        .foregroundColor(UIColor.secondaryLabel.color)
                }
                .padding(.horizontal, 16)
            }
            .foregroundColor(UIColor.label.color)
            .background(UIColor.systemBackground.color)
            .cornerRadius(16)
        }
    }
}
