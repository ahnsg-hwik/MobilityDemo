//
//  PicsumRepositoryClient.swift
//  Domain
//
//  Created by iOS_Hwik on 12/23/25.
//

import ComposableArchitecture

@DependencyClient
public struct PicsumRepositoryClient: Sendable {
    public var fetchPhotoList: @Sendable () async throws -> [PhotoList]
}

extension PicsumRepositoryClient: DependencyKey {
    public static var liveValue = Self()
}

extension DependencyValues {
    public var picsumRepositoryClient: PicsumRepositoryClient {
        get { self[PicsumRepositoryClient.self] }
        set { self[PicsumRepositoryClient.self] = newValue }
    }
}
