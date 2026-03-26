//
//  SplashFeature.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/31/25.
//

import ComposableArchitecture

@Reducer
public struct SplashFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case onTapNext
    }
    
    public init() {}
    
    @Dependency(\.continuousClock) var clock
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    try await self.clock.sleep(for: .milliseconds(2000))
                    await send(.onTapNext)
                }
            case .onTapNext:
                return .none
            }
        }
    }
}
