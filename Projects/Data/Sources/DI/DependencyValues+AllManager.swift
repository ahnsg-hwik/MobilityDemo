//
//  DependencyValues+AllManager.swift
//  Data
//
//  Created by iOS_Hwik on 4/9/26.
//

import ComposableArchitecture

extension DependencyValues {
    public mutating func setAllManager() {
        self.bluetoothManagerClient = .live
        self.cameraManagerClient = .live
        self.locationManagerClient = .live
    }
}
