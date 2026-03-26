//
//  Componet.swift
//  Manifests
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI

@MainActor
public struct ContentBackgroundView<ContentView: View>: View {
    @Binding var isPresented: Bool
    
    /// content
    var content: ContentView
    
    /// animation
    var animation: Animation = .easeOut(duration: 0.3)

    /// Should close on tap - default is `true`
    var closeOnTap: Bool = true
    
    /// Should Transition - default is `bottom`
    var edgeTransition: AnyTransition = .move(edge: .bottom)
    
    /// Background color for outside area
    var backgroundColor: Color = .clear
    
    public init(parmas: ContentBackgroundView<ContentView>.ContentBackgroundPatameters,
                isPresented: Binding<Bool>,
                @ViewBuilder content: () -> ContentView) {
        
        self.animation = parmas.animation
        self.closeOnTap = parmas.closeOnTap
        self.edgeTransition = parmas.edgeTransition
        self.backgroundColor = parmas.backgroundColor
        
        self._isPresented = isPresented
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            if isPresented {
                backgroundColor
                    .ignoresSafeArea()
                    .onTapGesture {
                        if closeOnTap && isPresented {
                            isPresented.toggle()
                        }
                    }
                
                content
                    .background(Color.clear)
                    .transition(edgeTransition)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .animation(animation, value: isPresented)
    }
}

extension ContentBackgroundView {
    public struct ContentBackgroundPatameters {
        /// animation
        var animation: Animation = .easeOut(duration: 0.3)

        /// Should close on tap - default is `true`
        var closeOnTap: Bool = true
        
        /// Should Transition - default is `bottom`
        var edgeTransition: AnyTransition = .move(edge: .bottom)
        
        /// Background color for outside area
        var backgroundColor: Color = .clear
        
        public func animation(_ animation: Animation) -> Self {
            var params = self
            params.animation = animation
            return params
        }
        
        public func closeOnTap(_ closeOnTap: Bool) -> Self {
            var params = self
            params.closeOnTap = closeOnTap
            return params
        }
        
        public func edgeTransition(_ edgeTransition: AnyTransition) -> Self {
            var params = self
            params.edgeTransition = edgeTransition
            return params
        }
        
        public func backgroundColor(_ backgroundColor: Color) -> Self {
            var params = self
            params.backgroundColor = backgroundColor
            return params
        }
    }
}
