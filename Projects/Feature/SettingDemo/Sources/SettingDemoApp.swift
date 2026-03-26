//
//  SettingDemoApp.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/26/25.
//

import SwiftUI
import Setting

@main
struct SettingDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SettingView(
                store: .init(
                    initialState: .init(),
                    reducer: { SettingFeature() }
                )
            )
        }
    }
}

#Preview {
    SettingView(
        store: .init(
            initialState: .init(),
            reducer: { SettingFeature() }
        )
    )
}
