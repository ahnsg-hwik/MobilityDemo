//
//  SettingView.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/26/25.
//

import SwiftUI
import ComposableArchitecture

import DSKit

public struct SettingView: View {
    var store: StoreOf<SettingFeature>
    
    public init(store: StoreOf<SettingFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List {
            Section(LocalizedSetting.mapSetting.localized, content: {
                Text(LocalizedSetting.mapSetting.localized)
                Text(LocalizedSetting.scale.localized)
            })
            
            Section(LocalizedSetting.appSetting.localized, content: {
                Text(LocalizedSetting.appSetting.localized)
                Text(LocalizedSetting.language.localized)
                    .onTapGesture {
                        store.send(.openSettings)
                    }
            })
            
            Section(LocalizedSetting.appInfo.localized, content: {
                HStack {
                    Text(LocalizedSetting.versionInfo.localized)
                    
                    Spacer()
                    
                    Text("현재 0.0.0 / 최신 0.0.0".localized)
                        .foregroundColor(.blue)
                }
            })
            
            Button(LocalizedSetting.back.localized, action: {
                store.send(.onTapBack)
            })
        }
        .navigationTitle(LocalizedSetting.settings.localized)
    }
}

#Preview {
    SettingView(
        store: Store(
            initialState: .init(),
            reducer: { SettingFeature() }
        )
    )
}
