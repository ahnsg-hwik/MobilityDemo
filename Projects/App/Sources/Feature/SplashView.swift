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
    @State private var isRiding = false
    
    public init(store: StoreOf<SplashFeature>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            Color(hex: "#FBFAFA").ignoresSafeArea()
            
            VStack {
                Image(.image(.bikeRiding))
                    .resizable()
                    .scaledToFit()
                    .padding(24*5)
                    .offset(y: isRiding ? -4 : 0)
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isRiding)
                    .foregroundColor(.white)
                
                VStack(alignment: .trailing, spacing: .zero) {
                    Text("Mobility")
                        .font(.system(size: 60, weight: .black, design: .rounded))
                        .foregroundColor(Color(.representation(.mdColor)))
                        .shadow(color: .white, radius: 0, x: 2.0, y: 2.0)
                        .shadow(color: .white, radius: 0, x: -3.0, y: 3.0)
                        .shadow(color: .white, radius: 0, x: 3.0, y: -3.0)
                        .shadow(color: .white, radius: 0, x: -3.0, y: -3.0)
                    
                    Text("Demo")
                        .font(.system(size: 35, weight: .black, design: .rounded))
                        .foregroundColor(Color(.representation(.mdSubColor)))
                        .offset(x: -30, y: -10)
                }
                .offset(y: -180)
            }
        }
        .onAppear {
            isRiding = true
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
