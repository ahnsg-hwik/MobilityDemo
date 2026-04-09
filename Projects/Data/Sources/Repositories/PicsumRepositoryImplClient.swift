//
//  PicsumRepositoryImplClient.swift
//  Data
//
//  Created by iOS_Hwik on 12/22/25.
//

import Moya

import Domain

extension PicsumRepositoryClient {
    // liveValue라는 이름 대신 명시적인 static 프로퍼티나 생성 로직을 제공합니다.
    public static var live: Self {
        return Self(
            fetchPhotoList: {
                // Moya 등을 이용한 실제 통신 로직
                try await NetworkingAPI.shared.request(MultiTarget(PicsumEndPoint.photoList))
            }
        )
    }
}
