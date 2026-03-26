//
//  MobilityResponseModel.swift
//  Domain
//
//  Created by iOS_Hwik on 1/9/26.
//

import Foundation

public enum MobilityType: String, Codable {
    case kickboard = "15"
    case bike = "16"
}

public struct MobilityResponseModel: Codable {
    public var resultCode: String
    public var resultMessage: String
    public var detailMessage: String?
    public var data: [Mobility]?
    
    public init(resultCode: String, resultMessage: String, detailMessage: String? = nil, data: [Mobility]? = nil) {
        self.resultCode = resultCode
        self.resultMessage = resultMessage
        self.detailMessage = detailMessage
        self.data = data
    }
}

public struct Mobility: Codable {
    public var equipmentID: Int
    public var qRID: String
    public var serviceRegionID: Int
    public var modelID: String
    public var equipmentKindCD: MobilityType
    public var lat: Double
    public var lon: Double
    public var helmetTypeCD: String
    public var helmetExistYn: String
    public var batteryPercentage: Int
    public var availableMinute: Int
    public var expectDistance: Int
    public var expectMinute: Int
    public var photoThumbnailURL: String
    public var photoURL: String
    
    public init(equipmentID: Int, qRID: String, serviceRegionID: Int, modelID: String, equipmentKindCD: MobilityType, lat: Double, lon: Double, helmetTypeCD: String, helmetExistYn: String, batteryPercentage: Int, availableMinute: Int, expectDistance: Int, expectMinute: Int, photoThumbnailURL: String, photoURL: String) {
        self.equipmentID = equipmentID
        self.qRID = qRID
        self.serviceRegionID = serviceRegionID
        self.modelID = modelID
        self.equipmentKindCD = equipmentKindCD
        self.lat = lat
        self.lon = lon
        self.helmetTypeCD = helmetTypeCD
        self.helmetExistYn = helmetExistYn
        self.batteryPercentage = batteryPercentage
        self.availableMinute = availableMinute
        self.expectDistance = expectDistance
        self.expectMinute = expectMinute
        self.photoThumbnailURL = photoThumbnailURL
        self.photoURL = photoURL
    }
}
