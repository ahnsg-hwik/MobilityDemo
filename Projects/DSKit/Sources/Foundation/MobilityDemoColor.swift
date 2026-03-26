//
//  MobilityDemoColor.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/23/26.
//

import SwiftUI

public enum MobilityDemoColor {
    case representation(Self.MobilityDemoColor)
    
    public var color: UIColor {
        switch self {
        case .representation(let name):
            switch name {
            case .mdColor:
                return DSKitAsset.mdColor.color
            case .mdSubColor:
                return DSKitAsset.mdSubColor.color
            }
        }
    }
    
    public var swiftUIColor: Color {
        switch self {
        case .representation(let name):
            switch name {
            case .mdColor:
                return DSKitAsset.mdColor.swiftUIColor
            case .mdSubColor:
                return DSKitAsset.mdSubColor.swiftUIColor
            }
        }
    }
}

public extension MobilityDemoColor {
    enum MobilityDemoColor {
        case mdColor
        case mdSubColor
    }
}
