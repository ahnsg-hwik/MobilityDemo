//
//  MobilityDemoImage.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/21/26.
//

///
/// enum 방식이 아닌 경우 아래와 같이 정의 필요
/// - DSKit 모듈
///
/// public class R {
///     public static let bundle = Bundle(for: R.self)
/// }
///
/// - Feature 모듈
///
/// Image("tooltip.back.penalty.zone", bundle: R.bundle)
///

import UIKit
import SwiftUI

public enum MobilityDemoImage {
    case marker(Self.Marker)
    case image(Self.MobilityDemoImage)
    
    ///
    /// example: MobilityDemoImage.image(.bike100).image
    ///
    public var image: UIImage {
        switch self {
        case .marker(let name):
            switch name {
            case .kickboard100:
                return DSKitAsset.pmKickboardPoint100.image
            case .kickboardSel100:
                return DSKitAsset.pmKickboardPointSel100.image
            case .kickboardClustering:
                return DSKitAsset.pmKickboardClusteringBig.image
            case .bike100:
                return DSKitAsset.pmBikePoint100.image
            case .bikeSel100:
                return DSKitAsset.pmBikePointSel100.image
            case .bikeClustering:
                return DSKitAsset.pmBikeClusteringBig.image
            case .spot:
                return DSKitAsset.pmSpotPointSmall.image
            }
        case .image(let name):
            switch name {
            case .bikeRiding:
                return DSKitAsset.bikeRiding.image
            }
        }
    }
    
    ///
    /// example: MobilityDemoImage.image(.bike100).swiftUIImage
    ///
    public var swiftUIImage: Image {
        switch self {
        case .marker(let name):
            switch name {
            case .kickboard100:
                return DSKitAsset.pmKickboardPoint100.swiftUIImage
            case .kickboardSel100:
                return DSKitAsset.pmKickboardPointSel100.swiftUIImage
            case .kickboardClustering:
                return DSKitAsset.pmKickboardClusteringBig.swiftUIImage
            case .bike100:
                return DSKitAsset.pmBikePoint100.swiftUIImage
            case .bikeSel100:
                return DSKitAsset.pmBikePointSel100.swiftUIImage
            case .bikeClustering:
                return DSKitAsset.pmBikeClusteringBig.swiftUIImage
            case .spot:
                return DSKitAsset.pmSpotPointSmall.swiftUIImage
            }
        case .image(let name):
            switch name {
            case .bikeRiding:
                return DSKitAsset.bikeRiding.swiftUIImage
            }
        }
    }
}

public extension MobilityDemoImage {
    enum Marker {
        case kickboard100
        case kickboardSel100
        case kickboardClustering
        case bike100
        case bikeSel100
        case bikeClustering
        case spot
    }
    
    enum MobilityDemoImage {
        case bikeRiding
    }
}
