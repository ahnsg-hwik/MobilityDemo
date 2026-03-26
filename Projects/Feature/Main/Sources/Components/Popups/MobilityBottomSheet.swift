//
//  MobilityBottomSheet.swift
//  Feature
//
//  Created by iOS_Hwik on 1/19/26.
//

import SwiftUI
import Domain
import DSKit

public struct MobilityBottomSheet: View {
    var data: Mobility
    var onTap: (() -> Void)?
    
    public var body: some View {
        BottomSheetView {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 20) {
                        Text("\(data.batteryPercentage)%")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .bold))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(data.modelID)
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                            
                            Text(data.qRID)
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text("약 \(data.expectDistance)km 주행할 수 있어요!")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .padding(.top, 4)
                }

                Spacer()

                Image(systemName: "bicycle")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(.gray)
                    .cornerRadius(5)
            }
            
            Text("대여 하기")
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.blue)
                .cornerRadius(12)
                .foregroundColor(.white)
                .padding(.top, 10)
                .onTapGesture {
                    onTap?()
                }
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        MobilityBottomSheet(data:
            Mobility(
                equipmentID: 20,
                qRID: "110002078",
                serviceRegionID: 1,
                modelID: "utech-scooter",
                equipmentKindCD: .bike,
                lat: 37.55637,
                lon: 126.969726,
                helmetTypeCD: "1",
                helmetExistYn: "Y",
                batteryPercentage: 100,
                availableMinute: 100, expectDistance: 25, expectMinute: 1, photoThumbnailURL: "", photoURL: ""
            )
        )
    }
}
