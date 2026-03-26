//
//  AuthGuideFeature.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 1/29/26.
//

import UIKit
import ComposableArchitecture
import Domain

@Reducer
public struct AuthGuideFeature {
    @ObservableState
    public struct State {
        var isSettingPresented: Bool = false
        
        public init() {}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case locationDelegate
        case bluetoothDelegate
        case locationAuthorization
        case bluetoothAuthorization
        case cameraAuthorization
        case completion
        case openSettingsButtonTapped(Bool)
        case openSettings
        case onTapNext
    }
    
    public init() {}
    
    @Dependency(\.locationManagerClient) var locationManagerClient
    @Dependency(\.bluetoothManagerClient) var bluetoothManagerClient
    @Dependency(\.cameraManagerClient) var cameraManagerClient
    
    @Dependency(\.openURL) var openURL
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .merge(
                    .send(.locationAuthorization)
                )
            case .locationDelegate:
                return .run { send in
                    let locationStream = try await locationManagerClient.delegate()
                    
                    for await action in locationStream {
                        if case .didChangeAuthorization = action, locationManagerClient.isAuthorization() {
                            await send(.bluetoothAuthorization)
                        }
                    }
                }
            case .bluetoothDelegate:
                return .run { send in
                    let bluetoothStream = try await bluetoothManagerClient.delegate()

                    for await action in bluetoothStream {
                        if case .didUpdateState = action, bluetoothManagerClient.isAuthorization() {
                            await send(.cameraAuthorization)
                        }
                    }
                }
                
            case .locationAuthorization:
                if locationManagerClient.checkAuthorization() { return .send(.bluetoothAuthorization) }
                return .send(.locationDelegate)
            case .bluetoothAuthorization:
                bluetoothManagerClient.createBluetooth()
                return .send(.bluetoothDelegate)
            case .cameraAuthorization:
                return .run { send in
                    if try await cameraManagerClient.checkAuthorization() {
                        await send(.onTapNext)
                    }
                }
                
            case .completion:
                return .none
                
            case let .openSettingsButtonTapped(isPresented):
                state.isSettingPresented = isPresented
                return .none
            case .openSettings:
                return .run { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        await self.openURL(url)
                    }
                }
            case .onTapNext:
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}
