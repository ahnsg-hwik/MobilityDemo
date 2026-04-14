//
//  SpotRepositoryClient.swift
//  Domain
//
//  Created by iOS_Hwik on 4/13/26.
//

import ComposableArchitecture

@DependencyClient
public struct SpotRepositoryClient: Sendable {
    public var fetchSpots: @Sendable () async throws -> [Spot]
}

extension SpotRepositoryClient: DependencyKey {
    public static var liveValue = Self()
}

extension DependencyValues {
    public var spotRepositoryClient: SpotRepositoryClient {
        get { self[SpotRepositoryClient.self] }
        set { self[SpotRepositoryClient.self] = newValue }
    }
}
