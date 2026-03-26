//
//  POIResponseModel.swift
//  Domain
//
//  Created by iOS_Hwik on 1/13/26.
//

import Foundation

public struct POIResponseModel: Hashable, Codable {
    public let resultCode, resultMessage, detailMessage: String?
    public let data: [PoiItem]?
    
    public init(resultCode: String?, resultMessage: String?, detailMessage: String?, data: [PoiItem]?) {
        self.resultCode = resultCode
        self.resultMessage = resultMessage
        self.detailMessage = detailMessage
        self.data = data
    }
}

public struct PoiItem: Hashable, Codable {
    public var seq: Int?
    public var poiID: String
    public var poiName: String
    public var lat, lon: Double
    public var landAddress, roadAddress, inaviCategoryCD, inaviCategoryName: String?
    public var hwikCategoryCD, hwikCategoryName, tel : String?
    public var distance: Int?
    public var images, menuImages: [ImageModel]?
    public var briefDescription, smartOrderYn: String?
    public var hwikReservationYn, hwikTogoYn, hwikTableOrderYn, resultType: String?
    
    public init(seq: Int? = nil, poiID: String, poiName: String, lat: Double, lon: Double, landAddress: String? = nil, roadAddress: String? = nil, inaviCategoryCD: String? = nil, inaviCategoryName: String? = nil, hwikCategoryCD: String? = nil, hwikCategoryName: String? = nil, tel: String? = nil, distance: Int? = nil, images: [ImageModel]? = nil, menuImages: [ImageModel]? = nil, briefDescription: String? = nil, smartOrderYn: String? = nil, hwikReservationYn: String? = nil, hwikTogoYn: String? = nil, hwikTableOrderYn: String? = nil, resultType: String? = nil) {
        self.seq = seq
        self.poiID = poiID
        self.poiName = poiName
        self.lat = lat
        self.lon = lon
        self.landAddress = landAddress
        self.roadAddress = roadAddress
        self.inaviCategoryCD = inaviCategoryCD
        self.inaviCategoryName = inaviCategoryName
        self.hwikCategoryCD = hwikCategoryCD
        self.hwikCategoryName = hwikCategoryName
        self.tel = tel
        self.distance = distance
        self.images = images
        self.menuImages = menuImages
        self.briefDescription = briefDescription
        self.smartOrderYn = smartOrderYn
        self.hwikReservationYn = hwikReservationYn
        self.hwikTogoYn = hwikTogoYn
        self.hwikTableOrderYn = hwikTableOrderYn
        self.resultType = resultType
    }
}

public struct ImageModel: Codable, Hashable {
    public var imagePath: String?
    
    public init(imagePath: String? = nil) {
        self.imagePath = imagePath
    }
}
