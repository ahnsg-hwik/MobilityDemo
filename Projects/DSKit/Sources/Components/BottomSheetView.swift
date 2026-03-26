//
//  BottomSheetView.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI
import Util

public struct BottomSheetView<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 12) {
            content
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
        .shadowedStyle()
    }
}
