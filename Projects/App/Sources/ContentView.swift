import ComposableArchitecture
import SwiftUI

import Data

@Reducer
public struct ContentFeature {
    @ObservableState
    public struct State: Equatable {
        var text = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onChangeText(String)
        case onTapNext
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onChangeText(let text):
                state.text = text
                return .none
            case .onTapNext:
                return .none
            case .binding:
                return .none
            }
        }
    }
}

public struct ContentView: View {
    @Bindable private var store: StoreOf<ContentFeature>
    
    public init(store: StoreOf<ContentFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            
            GroupBox {
                TextField("텍스트 입력", text: $store.text)
                    .textFieldStyle(.roundedBorder)
                
                Text("텍스트 결과 : \(store.text)")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            Button(action: {
                store.send(.onTapNext)
            }, label: {
                Text("Button")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.brown)
                    .clipShape(Capsule())
                    .shadowRadius2()
            })
            .padding()
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: ContentFeature.State()) {
            ContentFeature().body._printChanges()
        }
    )
}
