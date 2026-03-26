//
//  LocationClient.swift
//  Domain
//
//  Created by iOS_Hwik on 1/26/26.
//

import CoreLocation
import ComposableArchitecture

@DependencyClient
public struct LocationManagerClient {
    public var isAuthorization: @Sendable () -> Bool = { false }
    public var checkAuthorization: @Sendable () -> Bool = { false }
    public var fetchLocation: @Sendable () async throws -> CLLocationCoordinate2D?
    public var delegate: @Sendable () async throws -> AsyncStream<DelegateAction>
        
    public enum DelegateAction {
        case didUpdateLocations([CLLocation])
        case didFailWithError(Error)
        case didChangeAuthorization(CLAuthorizationStatus)
    }
}

extension LocationManagerClient: TestDependencyKey {
    public static var testValue = Self()
}

public extension DependencyValues {
    var locationManagerClient: LocationManagerClient {
        get { self[LocationManagerClient.self] }
        set { self[LocationManagerClient.self] = newValue }
    }
}
