//
//  View+Extension.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(radius: 2, x: 2, y: 2)
    }
}

extension View {
    public func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
    public func shadowRadius2() -> some View {
        modifier(ShadowModifier())
    }
}
