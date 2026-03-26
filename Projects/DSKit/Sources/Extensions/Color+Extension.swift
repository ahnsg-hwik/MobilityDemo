//
//  Color+Extension.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/23/26.
//

import SwiftUI

public extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        // Skip the '#' character if it exists
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

public extension Color {
    init(_ mobilityDemo: MobilityDemoColor) {
        self = mobilityDemo.swiftUIColor
    }
}
