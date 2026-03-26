//
//  Clustering+Extension.swift
//  Feature
//
//  Created by iOS_Hwik on 1/16/26.
//

import Domain
import Foundation

extension Clustering {
    public func getClusterLocation(of type: BubbleKeywordKind) -> [LocationModel] {
        switch type {
        case .kickboard:
            return kickBoardCluster
        case .bike:
            return bikeCluster
        default:
            return []
        }
    }
}
