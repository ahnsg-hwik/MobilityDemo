//
//  NaverMapMarkerData.swift
//  Feature
//
//  Created by iOS_Hwik on 1/13/26.
//

import NMapsMap
import Domain

public struct MarkerData {
    var fmsEquipment: [Mobility] = []
    var fmsClusteringLevel1: [LocationModel] = []
    var fmsClusteringLevel2: [LocationModel] = []
    var spot: [Spot] = []
    var poi: [PoiItem] = []
}

extension MarkerData {
    func filteredItems(for mode: BubbleKeywordKind, level: Int) -> [Markable] {
        switch mode {
        case .kickboard, .bike:
            let baseItems: [any Markable]
            switch level {
            case 1:  baseItems = fmsClusteringLevel1
            case 2:  baseItems = fmsClusteringLevel2
            default: baseItems = fmsEquipment
            }
            return baseItems + spot
        case .restaurant, .cafe:
            return poi
        }
    }
}
