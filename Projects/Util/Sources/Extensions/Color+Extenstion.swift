//
//  Extension.swift
//  Manifests
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI

public extension Color {
    static var random: Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
