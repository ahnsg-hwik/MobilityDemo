//
//  PicsumUseCaseClient.swift
//  Domain
//
//  Created by iOS_Hwik on 12/22/25.
//

import ComposableArchitecture

@DependencyClient
public struct PicsumUseCaseClient: Sendable {
    public var fetchPhotoList: @Sendable () async throws -> [PhotoList]
}

extension DependencyValues {
    public var picsumUseCaseClient: PicsumUseCaseClient {
        get { self[PicsumUseCaseKeyClient.self] }
        set { self[PicsumUseCaseKeyClient.self] = newValue }
    }
}

private enum PicsumUseCaseKeyClient: DependencyKey {
    public static var liveValue: PicsumUseCaseClient = {
        @Dependency(\.picsumRepositoryClient) var repository
        
        return PicsumUseCaseClient(
            fetchPhotoList: {
                try await repository.fetchPhotoList()
            }
        )
    }()
    
    public static var previewValue = PicsumUseCaseClient(
        fetchPhotoList: {
            let mock = [
                PhotoList(id: "1", author: "Alejandro Escamilla", width: 5000, height: 3333, url: "https://unsplash.com/photos/LNRyGwIJr5c", download_url: "https://picsum.photos/id/1/5000/3333"),
                PhotoList(id: "10", author: "Paul Jarvis", width: 5000, height: 3269, url: "https://unsplash.com/photos/ABDTiLqDhJA", download_url: "https://picsum.photos/id/9/5000/3269"),
                PhotoList(id: "20", author: "Aleks Dorohovich", width: 3670, height: 2462, url: "https://unsplash.com/photos/nJdwUHmaY8A", download_url: "https://picsum.photos/id/20/3670/2462"),
                PhotoList(id: "27", author: "Yoni Kaplan-Nadel", width: 3264, height: 1836, url: "https://unsplash.com/photos/iJnZwLBOB1I", download_url: "https://picsum.photos/id/27/3264/1836"),
            ]
            return mock
        }
    )
}
