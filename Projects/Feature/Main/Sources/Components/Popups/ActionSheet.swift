//
//  ActionSheet.swift
//  Feature
//
//  Created by iOS_Hwik on 1/6/26.
//

import SwiftUI
import DSKit

private struct ActivityView: View {
    let emoji: String
    let name: String
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.system(size: 24))

            Text(name.uppercased())
                .font(.system(size: 13, weight: isSelected ? .regular : .light))
                .foregroundColor(.black)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.yellow)
            }
        }
        .opacity(isSelected ? 1.0 : 0.8)
    }
}

public struct ActionSheetFirst: View {
    public var body: some View {
        ActionSheetView(bgColor: .white) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ActivityView(emoji: "🤼‍♂️", name: "Sparring", isSelected: true)
                    ActivityView(emoji: "🧘", name: "Yoga", isSelected: false)
                    ActivityView(emoji: "🚴", name: "cycling", isSelected: false)
                    ActivityView(emoji: "🏊", name: "Swimming", isSelected: false)
                    ActivityView(emoji: "🏄", name: "Surfing", isSelected: false)
                    ActivityView(emoji: "🤸", name: "Fitness", isSelected: false)
                    ActivityView(emoji: "⛹️", name: "Basketball", isSelected: true)
                    ActivityView(emoji: "🏋️", name: "Lifting Weights", isSelected: false)
                    ActivityView(emoji: "⚽️", name: "Football", isSelected: false)
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    public init() {}
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        ActionSheetFirst()
    }
}
