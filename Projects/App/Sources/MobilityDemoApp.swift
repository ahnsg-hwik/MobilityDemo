import SwiftUI
import ComposableArchitecture

@main
struct MobilityDemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: .init(),
                    reducer: { RootFeature() }
                )
            )
        }
    }
}
