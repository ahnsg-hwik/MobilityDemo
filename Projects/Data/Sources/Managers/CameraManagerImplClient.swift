//
//  CameraManagerImplClient.swift
//  Data
//
//  Created by iOS_Hwik on 2/2/26.
//

import AVFoundation
import ComposableArchitecture

import Domain

extension CameraManagerClient: @retroactive DependencyKey {
    public static let liveValue = CameraManagerClient.live
}

extension CameraManagerClient {
    static var live: Self {
        let camera = Camera()

        return Self(
            isAuthorization: {
                camera.isAuthorization
            }, checkAuthorization: {
                await camera.checkAuthorization()
            }, delegate: {
                camera.authorizationStream
            }
        )
    }
}

private final class Camera: NSObject {
    var isAuthorization: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    private var addToAuthorization: ((CameraManagerClient.DelegateAction) -> Void)?
    
    lazy var authorizationStream: AsyncStream<CameraManagerClient.DelegateAction> = {
        AsyncStream { continuation in
            addToAuthorization = { action in
                continuation.yield(action)
            }
        }
    }()
    
    override init() { super.init() }
    
    func checkAuthorization() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video) // 권한 팝업 표시
        default:
            return false
        }
    }
}
