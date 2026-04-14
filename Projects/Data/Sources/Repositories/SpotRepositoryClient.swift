//
//  SpotRepositoryClient.swift
//  Data
//
//  Created by iOS_Hwik on 4/13/26.
//

import Moya

import Domain

extension SpotRepositoryClient {
    public static var live: Self {
        return Self(
            fetchSpots: {
                // TODO: try await NetworkingAPI.shared.request(MultiTarget(...))
                return []
            }
        )
    }
}
