//
//  ClusteringResponseModel.swift
//  Domain
//
//  Created by iOS_Hwik on 1/13/26.
//

import Foundation

public struct ClusteringResponseModel: Codable {
    public var resultCode: String
    public var resultMessage: String
    public var data: Clustering?
    
    public init(resultCode: String, resultMessage: String, data: Clustering? = nil) {
        self.resultCode = resultCode
        self.resultMessage = resultMessage
        self.data = data
    }
}

public struct Clustering: Codable {
    public var nextTimeDiff: String
    public var level: Int
    public var kickBoardCluster: [LocationModel]
    public var bikeCluster: [LocationModel]
    
    public init(nextTimeDiff: String, level: Int, kickBoardCluster: [LocationModel], bikeCluster: [LocationModel]) {
        self.nextTimeDiff = nextTimeDiff
        self.level = level
        self.kickBoardCluster = kickBoardCluster
        self.bikeCluster = bikeCluster
    }
}

public struct LocationModel: Codable, Sendable {
    public let lat: Double
    public let lon: Double
    
    public let id: String = UUID().uuidString
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}
