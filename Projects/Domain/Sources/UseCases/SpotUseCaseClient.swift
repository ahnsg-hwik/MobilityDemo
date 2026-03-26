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
}

extension DependencyValues {
    public var spotUseCaseClient: SpotUseCaseClient {
        get { self[SpotUseCaseKeyClient.self] }
        set { self[SpotUseCaseKeyClient.self] = newValue }
    }
}

private enum SpotUseCaseKeyClient: DependencyKey {
    static var liveValue: SpotUseCaseClient = {
        return SpotUseCaseClient(
            fetchSpots: { spots }
        )
    }()
    
    static var previewValue = SpotUseCaseClient(
        fetchSpots: { spots }
    )
}

extension SpotUseCaseKeyClient {
    static var spots = [
        Spot(spotID: 0, lat: 37.532117, lon: 126.978115),
        Spot(spotID: 1, lat: 37.525650, lon: 126.987642),
        Spot(spotID: 2, lat: 37.523744, lon: 126.975110)
    ]
}
