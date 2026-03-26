//
//  InfoWindowContent.swift
//  Feature
//
//  Created by iOS_Hwik on 1/20/26.
//

import SwiftUI

struct InfoWindowContent: View {
    var type: InfoWindowDataSource
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(type == .NonReturn ? .white : .yellow)
            
            Text(description)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.white)
        }
        .padding(8)
        .padding(.bottom, 8)
        .background(
            BubbleShape()
                .fill(Color.blue)
                .shadow(radius: 2)
        )
    }
}

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 12
        let tailWidth: CGFloat = 12
        let tailHeight: CGFloat = 8

        // 메인 사각형 몸통
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tailHeight),
                            cornerSize: CGSize(width: cornerRadius, height: cornerRadius))

        // 중앙 하단 꼬리 부분 그리기
        path.move(to: CGPoint(x: rect.midX - tailWidth / 2, y: rect.height - tailHeight))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        path.addLine(to: CGPoint(x: rect.midX + tailWidth / 2, y: rect.height - tailHeight))
        
        return path
    }
}

#Preview {
    InfoWindowContent(type: .NonReturn,
                      title: "이곳은 반납 금지 구역 입니다.",
                      description: "킥보드는 스팟에서만 반납이 가능합니다.")
}
