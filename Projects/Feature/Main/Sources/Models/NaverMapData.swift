//
//  NaverMapData.swift
//  Feature
//
//  Created by iOS_Hwik on 1/8/26.
//

import Foundation
import Domain

public struct MapData: Equatable {
    var position: String = ""
    var lineCoordinates: [String] = []
    var serviceAreaGroup: ServiceAreaGroup?
    var keyword: BubbleKeywordKind = .kickboard
    var zoomLevel: Double = 0
    var level: Int = 0
}
