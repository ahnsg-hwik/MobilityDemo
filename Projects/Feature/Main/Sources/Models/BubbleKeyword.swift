//
//  BubbleKeyword.swift
//  Main
//
//  Created by iOS_Hwik on 12/19/25.
//

import SwiftUI

public enum BubbleKeywordKind: CaseIterable {
    case kickboard
    case bike
    case restaurant
    case cafe
    
    var imageName: String {
        switch self {
        case .kickboard:
            return "gear.circle.fill"
        case .bike:
            return "bicycle"
        case .restaurant:
            return "fork.knife"
        case .cafe:
            return "cup.and.saucer.fill"
        }
    }
    
    var name: String {
        switch self {
        case .kickboard:
            return "킥보드"
        case .bike:
            return "자전거"
        case .restaurant:
            return "음식점"
        case .cafe:
            return "카페"
        }
    }
    
    var color: Color {
        switch self {
        case .kickboard:
            return .blue
        case .bike:
            return .brown
        case .restaurant:
            return .red
        case .cafe:
            return .yellow
        }
    }
    
    var isMobility: Bool {
        self == .kickboard || self == .bike
    }
}
