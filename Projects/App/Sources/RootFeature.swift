//
//  RootFeature.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/17/25.
//

import ComposableArchitecture

@Reducer
public struct RootFeature {
    @ObservableState
    public enum State {
        case splash(SplashFeature.State)
        case auth(AuthGuideFeature.State)
        case intro(IntroFeature.State)
        
        public init() { self = .splash(.init()) }
    }
    
    public enum Action {
        case splash(SplashFeature.Action)
        case auth(AuthGuideFeature.Action)
        case intro(IntroFeature.Action)
    }
    
    public init() {}
    
    @Dependency(\.locationManagerClient) var locationManagerClient
    @Dependency(\.bluetoothManagerClient) var bluetoothManagerClient
    @Dependency(\.cameraManagerClient) var cameraManagerClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.onTapNext):
                let authorizations = [
                    locationManagerClient.isAuthorization(),
                    bluetoothManagerClient.isAuthorization(),
                    cameraManagerClient.isAuthorization()
                ]

                state = authorizations.allSatisfy { $0 } ? .intro(.init()) : .auth(.init())
                return .none
            case .auth(.onTapNext):
                state = .intro(.init())
                return .none
            case .splash, .auth, .intro:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) { SplashFeature() }
        .ifCaseLet(\.auth, action: \.auth) { AuthGuideFeature() }
        .ifCaseLet(\.intro, action: \.intro) { IntroFeature() }
    }
}
