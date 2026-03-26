//
//  BottomSheet.swift
//  Feature
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI
import DSKit

public struct BottomSheetFirst: View {
    var onTap: () -> Void
    
    public var body: some View {
        BottomSheetView {
            Image(systemName: "figure.strengthtraining.traditional")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 156, maxHeight: 156)
            
            Text("Personal offer")
                .foregroundColor(.black)
                .font(.system(size: 24))
                .padding(.top, 4)
            
            Text("Say hello to flexible funding – you're pre-screened for an exclusive personal loan offer through TD Bank. Enter your Personal Offer Code to get started.")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .opacity(0.6)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            
            Text("Read More")
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.blue)
                .cornerRadius(12)
                .foregroundColor(.white)
                .padding(.horizontal, 64)
                .onTapGesture {
                    onTap()
                }
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        BottomSheetFirst { }
    }
}
