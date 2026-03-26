//
//  BluetoothClient.swift
//  Domain
//
//  Created by iOS_Hwik on 1/30/26.
//

import CoreBluetooth
import ComposableArchitecture

@DependencyClient
public struct BluetoothManagerClient {
    public var isAuthorization: @Sendable () -> Bool = { false }
    public var checkAuthorization: @Sendable () -> Void
    public var createBluetooth: @Sendable () -> Void
    public var delegate: @Sendable () async throws -> AsyncStream<DelegateAction>
    
    public enum DelegateAction {
        case didUpdateState(CBManagerState)
    }
}

extension BluetoothManagerClient: TestDependencyKey {
    public static var testValue = Self()
}

public extension DependencyValues {
    var bluetoothManagerClient: BluetoothManagerClient {
        get { self[BluetoothManagerClient.self] }
        set { self[BluetoothManagerClient.self] = newValue }
    }
}
