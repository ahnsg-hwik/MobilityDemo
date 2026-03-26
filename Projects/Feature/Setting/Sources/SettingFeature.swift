//
//  SettingFeature.swift
//  Feature
//
//  Created by iOS_Hwik on 12/29/25.
//

import UIKit

import ComposableArchitecture

@Reducer
public struct SettingFeature {
    @ObservableState
    public struct State {
        public init() {}
    }
    
    public enum Action {
        case onTapBack
        case openSettings
    }
    
    public init() {}
    
    @Dependency(\.openURL) var openURL
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onTapBack:
                return .none
            case .openSettings:
                return .run { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        await self.openURL(url)
                    }
                }
            }
        }
    }
}
