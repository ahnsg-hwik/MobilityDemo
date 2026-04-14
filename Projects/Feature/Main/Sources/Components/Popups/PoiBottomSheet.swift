//
//  PoiBottomSheet.swift
//  Feature
//
//  Created by iOS_Hwik on 4/14/26.
//

import SwiftUI

import Domain
import DSKit

public struct PoiBottomSheet: View {
    var data: PoiItem
    var dismiss: (() -> Void)?
    
    public var body: some View {
        BottomSheetView {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(data.hwikCategoryName ?? "음식점")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    
                    Spacer()
                    
                    Image(systemName: "phone.circle.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.gray)
                    
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.gray)
                        .onTapGesture {
                            dismiss?()
                        }
                }
                
                Text(data.poiName)
                    .font(.system(size: 20, weight: .bold))
                
                if let desc = data.briefDescription {
                    Text(desc)
                        .lineLimit(1)
                }
                
                HStack(spacing: 10) {
                    Label(title: {
                        Text("예약")
                            .font(.system(size: 12))
                    }, icon: {
                        Image(systemName: "calendar")
                            .font(.system(size: 12, weight: .bold))
                    })
                    .padding(8)
                    .overlay(
                        Capsule() // 동일한 모양의 캡슐을 덧씌움
                            .stroke(Color.black, lineWidth: 1) // 테두리 색상과 두께 설정
                    )
                    
                    Label(title: {
                        Text("포장")
                            .font(.system(size: 12))
                    }, icon: {
                        Image(systemName: "bag.fill")
                            .font(.system(size: 12, weight: .bold))
                            .overlay {
                                Image(systemName: "fork.knife")
                                    .font(.system(size: 5, weight: .bold))
                                    .foregroundColor(.white)
                                    .offset(y: 1.5)
                            }
                    })
                    .padding(8)
                    .overlay(
                        Capsule() // 동일한 모양의 캡슐을 덧씌움
                            .stroke(Color.black, lineWidth: 1) // 테두리 색상과 두께 설정
                    )
                }
                .padding(.top, 10)
            }
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        
        PoiBottomSheet(data: PoiItem(poiID: "", poiName: "테라로사 커피 공장", lat: 0, lon: 0, briefDescription: "오직 강릉에서만 맛볼 수 있는 센마르만의 독특한 메뉴로"))
    }
}
