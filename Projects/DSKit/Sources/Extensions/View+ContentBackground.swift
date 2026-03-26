//
//  View+ContentBackground.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI

extension View {
    public func contentBackground<ContentView: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder view: @escaping () -> ContentView,
        customize: @escaping (ContentBackgroundView<ContentView>.ContentBackgroundPatameters) -> ContentBackgroundView<ContentView>.ContentBackgroundPatameters
        ) -> some View {
            self.modifier(
                FullscreenBackground(isPresented: isPresented,
                                     parmas: customize(ContentBackgroundView<ContentView>.ContentBackgroundPatameters()),
                                     contentView: view)
            )
    }
}

@MainActor
struct FullscreenBackground<ContentView: View>: ViewModifier {

    @Binding var isPresented: Bool
    
    var params: ContentBackgroundView<ContentView>.ContentBackgroundPatameters
    
    var contentView: ContentView
    
    init(isPresented: Binding<Bool> = .constant(false),
         parmas: ContentBackgroundView<ContentView>.ContentBackgroundPatameters,
         @ViewBuilder contentView: () -> ContentView) {
        self._isPresented = isPresented
        self.params = parmas
        self.contentView = contentView()
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            constructContent
        }
    }
    
    var constructContent: some View {
        ContentBackgroundView(
            parmas: self.params,
            isPresented: $isPresented) {
            contentView
        }
    }
}
