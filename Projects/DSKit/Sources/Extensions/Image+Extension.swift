//
//  Image+Extension.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/22/26.
//

import SwiftUI

public extension Image {
    /// 이미지 생성
    ///
    /// - Parameter mdkit: case 설정
    init(_ mobilityDemo: MobilityDemoImage) {
        self = mobilityDemo.swiftUIImage
    }
}
