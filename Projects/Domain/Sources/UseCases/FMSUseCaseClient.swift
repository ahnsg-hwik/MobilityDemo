//
//  FMSUseCaseClient.swift
//  Domain
//
//  Created by iOS_Hwik on 1/12/26.
//

import ComposableArchitecture

@DependencyClient
public struct FMSUseCaseClient: Sendable {
    public var fetchFMSEquipments: @Sendable (MobilityType) async throws -> [Mobility]
    public var fetchFMSClustering: @Sendable () async throws -> Clustering?
}

extension DependencyValues {
    public var fmsUseCaseClient: FMSUseCaseClient {
        get { self[FMSUseCaseKeyClient.self] }
        set { self[FMSUseCaseKeyClient.self] = newValue }
    }
}

private enum FMSUseCaseKeyClient: DependencyKey {
    static var liveValue: FMSUseCaseClient = {
        return FMSUseCaseClient(
            fetchFMSEquipments: { type in
                switch type {
                case .bike:
                    return bikeMobility
                case .kickboard:
                    return kickboardMobility
                }
            },
            fetchFMSClustering: {
                clutering
            }
        )
    }()
    
    static var previewValue = FMSUseCaseClient(
        fetchFMSEquipments: { type in
            switch type {
            case .bike:
                return bikeMobility
            case .kickboard:
                return kickboardMobility
            }
        },
        fetchFMSClustering: {
            clutering
        }
    )
}

extension FMSUseCaseKeyClient {
    static var bikeMobility = [
        Mobility(
            equipmentID: 2034,
            qRID: "110002034",
            serviceRegionID: 1,
            modelID: "utech-bike",
            equipmentKindCD: .bike,
            lat: 37.554462,
            lon: 126.974002,
            helmetTypeCD: "1",
            helmetExistYn: "Y",
            batteryPercentage: 100,
            availableMinute: 120,
            expectDistance: 132,
            expectMinute: 1,
            photoThumbnailURL: "https://hwik-upload.hwikservice.com/hwikgo/rental/thumbnail/9714_110002034_15.png",
            photoURL: "https://hwik-upload.hwikservice.com/hwikgo/rental/return/9714_110002034_15.png"
        ),
        Mobility(
            equipmentID: 86,
            qRID: "110000086",
            serviceRegionID: 1,
            modelID: "utech-bike",
            equipmentKindCD: .bike,
            lat: 37.554276,
            lon: 126.974342,
            helmetTypeCD: "1",
            helmetExistYn: "N",
            batteryPercentage: 70,
            availableMinute : 84,
            expectDistance: 162,
            expectMinute: 1,
            photoThumbnailURL: "https://hwik-upload.hwikservice.com/hwikgo/rental/thumbnail/9505_110000086_15.png",
            photoURL: "https://hwik-upload.hwikservice.com/hwikgo/rental/return/9505_110000086_15.png"

        )
    ]
    
    static var kickboardMobility = [
        Mobility(
            equipmentID: 20,
            qRID: "110002078",
            serviceRegionID: 1,
            modelID: "utech-scooter",
            equipmentKindCD: .kickboard,
            lat: 37.55637,
            lon: 126.969726,
            helmetTypeCD: "1",
            helmetExistYn: "Y",
            batteryPercentage: 100,
            availableMinute: 100, 
            expectDistance: 100,
            expectMinute: 1,
            photoThumbnailURL: "",
            photoURL: ""
        )
    ]
    
    static var clutering = Clustering(
        nextTimeDiff: "", level: 0,
        kickBoardCluster: [LocationModel(lat: 37.554628, lon: 126.974031)],
        bikeCluster: [LocationModel(lat: 37.559459, lon: 126.973087)]
    )
}
