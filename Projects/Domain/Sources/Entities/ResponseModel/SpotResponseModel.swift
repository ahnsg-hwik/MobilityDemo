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
