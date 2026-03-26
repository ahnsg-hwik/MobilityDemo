//
//  InfoDataSource.swift
//  Feature
//
//  Created by iOS_Hwik on 1/20/26.
//

import SwiftUI
import NMapsMap
import DSKit

class InfoDataSource: NSObject, NMFOverlayImageDataSource {
    private var topText: String
    private var bottomText: String
    private var type: InfoWindowDataSource
    
    private let imageSize = CGSize(width: 200, height: 50)

    init(_ type: InfoWindowDataSource, topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
        self.type = type
    }

    func view(with overlay: NMFOverlay) -> UIView {
        guard overlay is NMFInfoWindow else { return UIView() }

        // SwiftUI 화면 보이지 않는 이슈
        // - 화면 최상위 SwiftUI 화면을 그리고 캡쳐 후 삭제
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let topPadding = window.safeAreaInsets.top // 디바이스 상단 노치 영역
            let origin = CGPoint(x: .zero, y: topPadding)
            let size = CGSize(width: imageSize.width + 8,
                              height: imageSize.height + 8)
            
            // SwiftUI 화면 생성
            let hostingController = createInfoWindowContent(rect: CGRect(origin: origin, size: size))

            // hostingController.view 추가
            window.rootViewController?.view.insertSubview(hostingController.view, at: 0)
            
            // 이미지 캡쳐
            let infoWindowImage = hostingController.view.asImage(size: size)

            // 이미지뷰 생성
            let imageView = UIImageView(image: infoWindowImage)
            imageView.frame = CGRect(origin: .zero, size: size)
            
            // hostingController.view 제거
            hostingController.view.removeFromSuperview()
            
            return imageView
        }
        
        return UIView()
    }
    
    func createInfoWindowContent(rect: CGRect) -> UIHostingController<some View> {
        let content = InfoWindowContent(type: type, title: topText, description: bottomText)
        let hostingController = UIHostingController(rootView: content.edgesIgnoringSafeArea(.all))
        hostingController.view.frame = rect
        hostingController.view.backgroundColor = .clear
        
        return hostingController
    }
}
