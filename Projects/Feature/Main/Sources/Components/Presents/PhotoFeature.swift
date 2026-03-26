//
//  PhotoFeature.swift
//  Main
//
//  Created by iOS_Hwik on 12/23/25.
//

import ComposableArchitecture
import Domain

@Reducer
public struct PhotoFeature {
    @ObservableState
    public struct State {
        var photoList: [PhotoList] = []
    }
    
    public enum Action {
        case onAppear
        case onChangePotoList([PhotoList])
        case fetchPotoList
        case closeButtonTapped
    }
    
    public init() {}
    
    @Dependency(\.picsumUseCaseClient) var picsumUseCaseClient
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchPotoList)
            case let .onChangePotoList(photoList):
                state.photoList = photoList
                return .none
            case .fetchPotoList:
                return .run { send in
                    let response = try await picsumUseCaseClient.fetchPhotoList()
                    await send(.onChangePotoList(response))
                }
            case .closeButtonTapped:
                return .none
            }
        }
    }
}
