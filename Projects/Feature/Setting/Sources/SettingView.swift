//
//  SettingView.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/26/25.
//

import SwiftUI
import ComposableArchitecture

import DSKit

//public struct SettingView: View {
//    @Perception.Bindable private var store: StoreOf<SettingFeature>
//    
//    public init(store: StoreOf<SettingFeature>) {
//        self.store = store
//    }
//    
//    public var body: some View {
//        WithPerceptionTracking {
//            List {
//                Section("지도 설정", content: {
//                    Text("지도 설정")
//                    Text("축척 항상 표시")
//                })
//                
//                Section("앱 설정", content: {
//                    Text("앱 설정")
//                    Text("언어")
//                        .onTapGesture {
//                            store.send(.openSettings)
//                        }
//                })
//                
//                Section("앱 정보", content: {
//                    HStack {
//                        Text("앱 버전")
//                        
//                        Spacer()
//                        
//                        Text("현재 0.0.0 / 최신 0.0.0".localized)
//                            .foregroundColor(.blue)
//                    }
//                })
//                
//                Button("뒤로가기", action: {
//                    store.send(.onTapBack)
//                })
//            }
//            .navigationTitle("설정")
//        }
//    }
//}
public struct SettingView: View {
    @Perception.Bindable private var store: StoreOf<SettingFeature>
    
    public init(store: StoreOf<SettingFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
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
}

#Preview {
    SettingView(
        store: Store(
            initialState: .init(),
            reducer: { SettingFeature() }
        )
    )
}
