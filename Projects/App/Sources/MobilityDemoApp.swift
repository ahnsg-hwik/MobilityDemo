import SwiftUI
import ComposableArchitecture

import Domain
import Data

@main
struct MobilityDemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: .init()) {
                    RootFeature()
                } withDependencies: {
                    $0.setAllManager()
                    $0.setAllRepository()
                }
            )
        }
    }
}
