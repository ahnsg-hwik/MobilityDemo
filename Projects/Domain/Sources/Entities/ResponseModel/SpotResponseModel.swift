//
//  SpotResponseModel.swift
//  Domain
//
//  Created by iOS_Hwik on 1/13/26.
//

import Foundation

public struct SpotResponseModel: Codable, Sendable {
    public let resultCode, resultMessage, detailMessage: String?
    public let data: [Spot]?
    
    public init(resultCode: String?, resultMessage: String?, detailMessage: String?, data: [Spot]?) {
        self.resultCode = resultCode
        self.resultMessage = resultMessage
        self.detailMessage = detailMessage
        self.data = data
    }
}

public struct Spot: Codable, Sendable {
    public var spotID: Int
    public var lat: Double
    public var lon: Double
    
    public init(spotID: Int, lat: Double, lon: Double) {
        self.spotID = spotID
        self.lat = lat
        self.lon = lon
    }
}

public struct SpotDetailResponse: Codable, Sendable {
    public var resultCode: String
    public var resultMessage: String
    public var detailMessage: String?
    public var data: SpotDetail?
    
    public init(resultCode: String, resultMessage: String, detailMessage: String? = nil, data: SpotDetail? = nil) {
        self.resultCode = resultCode
        self.resultMessage = resultMessage
        self.detailMessage = detailMessage
        self.data = data
    }
}

public struct SpotDetail: Codable, Sendable {
    public var spotID: Int
    public var spotGroupID: Int
    public var spotName: String
    public var lat: Double
    public var lon: Double
    public var spotAddress: String
    public var spotStatusCD: String
    public var maxSpotGroupPoint: Int
    public var spotPhotos: [SpotPhoto?]
    
    public init(spotID: Int, spotGroupID: Int, spotName: String, lat: Double, lon: Double, spotAddress: String, spotStatusCD: String, maxSpotGroupPoint: Int, spotPhotos: [SpotPhoto?]) {
        self.spotID = spotID
        self.spotGroupID = spotGroupID
        self.spotName = spotName
        self.lat = lat
        self.lon = lon
        self.spotAddress = spotAddress
        self.spotStatusCD = spotStatusCD
        self.maxSpotGroupPoint = maxSpotGroupPoint
        self.spotPhotos = spotPhotos
    }
}

public struct SpotPhoto: Codable, Sendable {
    public var spotPhotoID: Int
    public var spotPhoto: String
    public var sortOrder: Int
    
    public init(spotPhotoID: Int, spotPhoto: String, sortOrder: Int) {
        self.spotPhotoID = spotPhotoID
        self.spotPhoto = spotPhoto
        self.sortOrder = sortOrder
    }
}
