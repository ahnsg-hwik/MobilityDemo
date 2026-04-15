//
//  TuistRelease.swift
//  Manifests
//
//  Created by iOS_Hwik on 4/15/26.
//

import Foundation

public enum TuistRelease {
    public static let tuistRelease = ProcessInfo.processInfo.environment["TUIST_RELEASE"] // TUIST 명령어 환경 변수. 예) TUIST_RELEASE="Release" tuist generate
    public static let isRelease = tuistRelease == "Release"
}
