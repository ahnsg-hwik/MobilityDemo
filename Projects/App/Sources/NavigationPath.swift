//
//  NavigationPath.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/31/25.
//

import ComposableArchitecture

import Main
import Setting

@Reducer
public struct NavigationPath {
    @ObservableState
    public enum State {
        case setting(SettingFeature.State)
    }
    
    public enum Action {
        case setting(SettingFeature.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.setting, action: \.setting, child: { SettingFeature() })
    }
}

public extension IntroFeature {
    var navigationReducer: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .path(.element(id: id, action: .setting(.onTapBack))):
                state.path.pop(from: id)
                return .send(.main(.onMenuButtonTapped(true)))
            case .main(.onTapSetting):
                state.path.append(.setting(SettingFeature.State()))
                return .none
            default: return .none
            }
        }
        .forEach(\.path, action: \.path) {
            NavigationPath()
        }
    }
}
