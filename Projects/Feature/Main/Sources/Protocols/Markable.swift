//
//  Markable.swift
//  Feature
//
//  Created by iOS_Hwik on 1/13/26.
//

import NMapsMap

import Domain
import DSKit

public protocol Markable {
    var latitude: Double { get }
    var longitude: Double { get }
    
    var image: UIImage { get }
    var selectedImage: UIImage { get }
    
    var identifiable: String { get }
}

extension Mobility: Markable {
    public var latitude: Double { lat }
    public var longitude: Double { lon }

    public var image: UIImage {
        switch equipmentKindCD {
        case .kickboard:
            return MobilityDemoImage.marker(.kickboard100).image
        case .bike:
            return MobilityDemoImage.marker(.bike100).image
        }
    }
    public var selectedImage: UIImage {
        switch equipmentKindCD {
        case .kickboard:
            return MobilityDemoImage.marker(.kickboardSel100).image
        case .bike:
            return MobilityDemoImage.marker(.bikeSel100).image
        }
    }
    
    public var identifiable: String { String(describing: Mobility.self) + qRID }
}

extension Spot: Markable {
    public var latitude: Double { lat }
    public var longitude: Double { lon }
    
    public var image: UIImage { MobilityDemoImage.marker(.spot).image }
    public var selectedImage: UIImage { MobilityDemoImage.marker(.spot).image }
    
    public var identifiable: String { String(describing: Spot.self) + String(spotID) }
}

extension LocationModel: Markable {
    public var latitude: Double { lat }
    public var longitude: Double { lon }
    
    public var image: UIImage { NMF_MARKER_IMAGE_GREEN.image }
    public var selectedImage: UIImage { NMF_MARKER_IMAGE_PINK.image }
    
    public var identifiable: String { String(describing: LocationModel.self) + id }
}

extension PoiItem: Markable {
    public var latitude: Double { lat }
    public var longitude: Double { lon }
    
    public var image: UIImage { NMF_MARKER_IMAGE_PINK.image }
    public var selectedImage: UIImage { NMF_MARKER_IMAGE_GREEN.image }
    
    public var identifiable: String { String(describing: PoiItem.self) + poiID }
}
