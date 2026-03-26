//
//  RootView.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/17/25.
//

import SwiftUI
import ComposableArchitecture

public struct RootView: View {
    let store: StoreOf<RootFeature>
    
    public init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            switch store.state {
            case .splash:
                if let store = store.scope(state: \.splash, action: \.splash) {
                    SplashView(store: store)
                }
            case .auth:
                if let store = store.scope(state: \.auth, action: \.auth) {
                    AuthGuideView(store: store)
                }
            case .intro:
                if let store = store.scope(state: \.intro, action: \.intro) {
                    IntroView(store: store)
                }
            }
        }
    }
}

#Preview {
    RootView(
        store: Store(
            initialState: .init(),
            reducer: { RootFeature() }
        )
    )
}
