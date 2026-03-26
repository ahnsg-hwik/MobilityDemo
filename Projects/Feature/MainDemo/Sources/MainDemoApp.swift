//
//  MainDemoApp.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/26/25.
//

import SwiftUI
import Main

@main
struct MainDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: .init(
                    initialState: .init(),
                    reducer: { MainFeature() }
                )
            )
        }
    }
}

#Preview {
    MainView(
        store: .init(
            initialState: .init(),
            reducer: { MainFeature() }
        )
    )
}
