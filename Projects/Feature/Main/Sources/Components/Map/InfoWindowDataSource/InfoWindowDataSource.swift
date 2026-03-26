//
//  InfoWindowDataSource.swift
//  Feature
//
//  Created by iOS_Hwik on 1/20/26.
//

import NMapsMap

enum InfoWindowDataSource {
    case NonReturn
    case NonServiceArea
    
    func getDataSource() -> NMFOverlayImageDataSource {
        switch self {
        case .NonReturn:
            return InfoDataSource(.NonReturn, topText: "이곳은 반납 금지 구역 입니다.", bottomText: "킥보드는 스팟에서만 반납이 가능합니다.")
        case .NonServiceArea:
            return InfoDataSource(.NonServiceArea, topText: "서비스 지역이 아닙니다.", bottomText: "이곳에 반납시 추가금액이 발생해요!")
        }
    }
}
