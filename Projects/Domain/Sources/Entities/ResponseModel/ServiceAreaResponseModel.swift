//
//  ServiceAreaResponseModel.swift
//  Domain
//
//  Created by iOS_Hwik on 1/7/26.
//

import Foundation

public enum MAP_AREA: String, Codable {
    case NON_RETURN_AREA = "33"
    case NON_SERVICE_AREA = "22"
    case SERVICE_AREA = "11"
}

public struct ServiceAreaResponseModel: Codable {
    public var resultCode: String
    public var resultMessage: String
    public var detailMessage: String?
    public var data: ServiceAreaGroup?
    
    public init(resultCode: String, resultMessage: String, detailMessage: String? = nil, data: ServiceAreaGroup? = nil) {
        self.resultCode = resultCode
        self.resultMessage = resultMessage
        self.detailMessage = detailMessage
        self.data = data
    }
}

public struct ServiceAreaGroup: Codable, Equatable {
    public var serviceAvailable: ServiceArea
    public var serviceDisable: ServiceArea
    public var returnDisable: ServiceArea
    
    public init(serviceAvailable: ServiceArea, serviceDisable: ServiceArea, returnDisable: ServiceArea) {
        self.serviceAvailable = serviceAvailable
        self.serviceDisable = serviceDisable
        self.returnDisable = returnDisable
    }
}

public struct ServiceArea: Codable, Equatable {
    public var geofenceTypeCD: MAP_AREA
    public var geofenceTypeCDName: String
    public var geofences: [Geofence]
    
    public init(geofenceTypeCD: MAP_AREA, geofenceTypeCDName: String, geofences: [Geofence]) {
        self.geofenceTypeCD = geofenceTypeCD
        self.geofenceTypeCDName = geofenceTypeCDName
        self.geofences = geofences
    }
}

public struct Geofence: Codable, Equatable {
    public var serviceRegionID: Int
    public var serviceRegionName: String
    public var geofenceID: Int
    public var details: [GeofenceDetail]
    
    public init(serviceRegionID: Int, serviceRegionName: String, geofenceID: Int, details: [GeofenceDetail]) {
        self.serviceRegionID = serviceRegionID
        self.serviceRegionName = serviceRegionName
        self.geofenceID = geofenceID
        self.details = details
    }
}

public struct GeofenceDetail: Codable, Equatable {
    public var lat: Double
    public var lon: Double
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
