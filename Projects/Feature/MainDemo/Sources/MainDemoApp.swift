//
//  MainDemoApp.swift
//  Manifests
//
//  Created by iOS_Hwik on 12/26/25.
//

import SwiftUI

import Domain
import Data

import Main

@main
struct MainDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: .init( initialState: .init()) {
                    MainFeature()
                } withDependencies: {
                    $0.setAllManager()
                    $0.setAllRepository()
                }
            )
        }
    }
}

#Preview {
    MainView(
        store: .init( initialState: .init()) {
            MainFeature()
        } withDependencies: {
            $0.setAllManager()
            $0.setAllRepository()
        }
    )
}
