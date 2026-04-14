//
//  SpotUseCaseClient.swift
//  Domain
//
//  Created by iOS_Hwik on 1/14/26.
//

import ComposableArchitecture

@DependencyClient
public struct SpotUseCaseClient: Sendable {
    public var fetchSpots: @Sendable () async throws -> [Spot]
    public var fetchSpotDetail: @Sendable () async throws -> SpotDetail
}

extension DependencyValues {
    public var spotUseCaseClient: SpotUseCaseClient {
        get { self[SpotUseCaseKeyClient.self] }
        set { self[SpotUseCaseKeyClient.self] = newValue }
    }
}

private enum SpotUseCaseKeyClient: DependencyKey {
    static var liveValue: SpotUseCaseClient = {
//        @Dependency(\.spotRepositoryClient) var repository
        
        return SpotUseCaseClient(
            fetchSpots: { spots },
            fetchSpotDetail: { spotDetail }
        )
    }()
    
    static var previewValue = SpotUseCaseClient(
        fetchSpots: { spots },
        fetchSpotDetail: { spotDetail }
    )
}

extension SpotUseCaseKeyClient {
    static var spots = [
        Spot(spotID: 0, lat: 37.532117, lon: 126.978115),
        Spot(spotID: 1, lat: 37.525650, lon: 126.987642),
        Spot(spotID: 2, lat: 37.523744, lon: 126.975110)
    ]
    
    static var spotDetail = SpotDetail(spotID: 0, spotGroupID: 0, spotName: "안목커피거리 해맞이 공원", lat: 0, lon: 0, spotAddress: "강원도 강릉시 안현동 산 2-11", spotStatusCD: "", maxSpotGroupPoint: 0, spotPhotos: [])
}
