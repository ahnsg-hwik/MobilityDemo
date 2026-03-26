//
//  IntroView.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 12/29/25.
//

import SwiftUI
import ComposableArchitecture

import Main
import Setting

public struct IntroView: View {
    @Bindable private var store: StoreOf<IntroFeature>
    
    public init(store: StoreOf<IntroFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            content
        } destination: { store in
            switch store.state {
            case .setting:
                if let store = store.scope(state: \.setting, action: \.setting) {
                    SettingView(store: store)
                }
            }
        }
    }
}

private extension IntroView {
    var content: some View {
        MainView(store: store.scope(state: \.main, action: \.main))
    }
}
