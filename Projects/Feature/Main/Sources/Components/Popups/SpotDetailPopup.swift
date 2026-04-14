//
//  SpotDetailPopup.swift
//  Feature
//
//  Created by iOS_Hwik on 4/14/26.
//

import SwiftUI

import Domain

public struct SpotDetailPopup: View {
    let data: SpotDetail
    var dismiss: (() -> Void)?
    
    public var body: some View {
        VStack(spacing: 12) {
            VStack {
                Image(systemName: "bicycle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blue)
                    .frame(maxWidth: 150, maxHeight: 200)
            }
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.1))
            .cornerRadius(10)

            VStack(spacing: 10) {
                Text(data.spotName)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                
                Label {
                    Text(data.spotAddress)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                } icon: {
                    Image(systemName: "pin")
                        .font(.system(size: 16))
                }
            }
            .padding(.vertical, 15)
            
            Button {
                dismiss?()
            } label: {
                Text("확인")
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 24)
                    .foregroundColor(.white)
                    .background(Color(hex: "FF7CAA"))
                    .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
        .shadowedStyle()
        .padding(.horizontal, 40)
    }
}

#Preview {
    SpotDetailPopup(data: SpotDetail(spotID: 0, spotGroupID: 0, spotName: "안목커피거리 해맞이 공원", lat: 0, lon: 0, spotAddress: "강원도 강릉시 안현동 산 2-11", spotStatusCD: "", maxSpotGroupPoint: 0, spotPhotos: [])) { }
}
