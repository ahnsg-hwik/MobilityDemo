//
//  View+CornerRadius.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI

struct RoundedShape: Shape {
    var radius: CGFloat = .zero
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: .init(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        let shape = RoundedShape(radius: radius, corners: corners)
        return clipShape(shape)
    }
}
