//
//  BluetoothImplClient.swift
//  Data
//
//  Created by iOS_Hwik on 1/30/26.
//

import CoreBluetooth
import ComposableArchitecture
import Domain

extension BluetoothManagerClient: @retroactive DependencyKey {
    public static let liveValue = BluetoothManagerClient.live
}

extension BluetoothManagerClient {
    public static var live: Self {
        let bluetooth = Bluetooth()
        
        return Self(
            isAuthorization: {
                bluetooth.isAuthorization
            }, checkAuthorization: {
                bluetooth.checkAuthorization()
            }, createBluetooth: {
                bluetooth.createBluetooth()
            }, delegate: {
                bluetooth.authorizationStream
            }
        )
    }
}

private final class Bluetooth: NSObject {
    private var bluetoothManager: CBCentralManager? = nil
    
    var isAuthorization: Bool {
        CBCentralManager.authorization == .allowedAlways
    }
    
    var isPowerOn: Bool {
        bluetoothManager?.state == .poweredOn
    }
    
    private var addToAuthorization: ((BluetoothManagerClient.DelegateAction) -> Void)?
    
    lazy var authorizationStream: AsyncStream<BluetoothManagerClient.DelegateAction> = {
        AsyncStream { continuation in
//            continuation.onTermination = { _ in
//            }
            
            addToAuthorization = { action in
                continuation.yield(action)
            }
        }
    }()
    
    override init() { super.init() }
    
    func createBluetooth() {
        if bluetoothManager == nil {
            bluetoothManager = CBCentralManager(delegate: self, queue: nil) // 권한 팝업 표시
        }
    }
    
    func checkAuthorization() {
        switch CBCentralManager.authorization {
        case .allowedAlways:
            break
        default:
            break
        }
    }
}

extension Bluetooth: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        addToAuthorization?(.didUpdateState(central.state))
    }
}
