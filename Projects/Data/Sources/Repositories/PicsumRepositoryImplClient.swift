//
//  PicsumRepositoryImplClient.swift
//  Data
//
//  Created by iOS_Hwik on 12/22/25.
//

import ComposableArchitecture
import Moya
import Domain

extension PicsumRepositoryClient: @retroactive DependencyKey {
    public static var liveValue: Self {
        return Self(
            fetchPhotoList: {
                try await NetworkingAPI.shared.request(MultiTarget(PicsumEndPoint.photoList))
            }
        )
    }
}
