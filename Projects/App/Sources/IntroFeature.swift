//
//  IntroFeature.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/31/25.
//

import ComposableArchitecture
import Main

@Reducer
public struct IntroFeature {
    @ObservableState
    public struct State {
        var path = StackState<NavigationPath.State>()
        var main = MainFeature.State()
        
        public init() {}
    }
    
    public enum Action {
        case path(StackActionOf<NavigationPath>)
        case main(MainFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.main, action: \.main) { MainFeature() }
        
        navigationReducer
        
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
    }
}
