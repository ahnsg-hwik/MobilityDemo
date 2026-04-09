//
//  CameraManagerClient.swift
//  Domain
//
//  Created by iOS_Hwik on 2/2/26.
//

import ComposableArchitecture

@DependencyClient
public struct CameraManagerClient {
    public var isAuthorization: @Sendable () -> Bool = { false }
    public var checkAuthorization: @Sendable () async throws -> Bool
    public var delegate: @Sendable () async throws -> AsyncStream<DelegateAction>
    
    public enum DelegateAction {
        case none
    }
}

extension CameraManagerClient: DependencyKey {
    public static var liveValue = Self()
}

extension DependencyValues {
    public var cameraManagerClient: CameraManagerClient {
        get { self[CameraManagerClient.self] }
        set { self[CameraManagerClient.self] = newValue }
    }
}
