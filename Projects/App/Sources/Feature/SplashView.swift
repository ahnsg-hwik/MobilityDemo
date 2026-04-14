//
//  SplashView.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/31/25.
//

import SwiftUI
import ComposableArchitecture

import DSKit

public struct SplashView: View {
    var store: StoreOf<SplashFeature>
    
    public init(store: StoreOf<SplashFeature>) {
        self.store = store
    }

    public var body: some View {
        Image(.image(.MDSplash))
            .onAppear {
                store.send(.onAppear)
            }
    }
}

#Preview {
    SplashView(
        store: Store(
            initialState: .init(),
            reducer: { SplashFeature() }
        )
    )
}
