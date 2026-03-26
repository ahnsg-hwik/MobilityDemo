//
//  Setting+Enum.swift
//  DSKit
//
//  Created by iOS_Hwik on 2/24/26.
//

import Foundation

public enum LocalizedMain {
}

public enum LocalizedSetting: String {
    case mapSetting = "지도 설정"
    case scale = "축척 항상 표시"
    case appSetting = "앱 설정"
    case language = "언어"
    case appInfo = "앱 정보"
    case back = "뒤로가기"
    case versionInfo = "버전 정보"
    case settings = "설정"
    
    public var localized: String {
        self.rawValue.localized
    }
}
