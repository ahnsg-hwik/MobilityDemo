//
//  MainFeature.swift
//  Main
//
//  Created by iOS_Hwik on 12/16/25.
//

import UIKit

import ComposableArchitecture
import Domain
import Setting

@Reducer
public struct MainFeature {
    @ObservableState
    public struct State {
        // MARK: map
        var keyword: BubbleKeywordKind = .kickboard
        var selectedMarkerData: (any Markable)?
        
        // MARK: popup
        var isPopupPresented = false
        var isSheetPresented = false
        var isMarkerPresented = false
        
        // MARK: present
        var isMenuPresented = false
        
        // MARK: sheet
        @Presents var sheet: PhotoFeature.State?
        
        // MARK: scope (child feature)
        var naverMap = NaverMapFeature.State()

        public init() {}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        // MARK: View
        case onAppear
        
        // MARK: Navigation
        case onTapSetting
        
        // MARK: map
        case onChangeBubbleKeywordKind(BubbleKeywordKind)
        case onCurrentLocation

        // MARK: popup
        case onPopupButtonTapped(Bool)
        case onSheetButtonTapped(Bool)
        case onMarkerTapped(Bool)
        
        // MARK: present
        case onMenuButtonTapped(Bool)
        
        // MARK: sheet
        case sheet(PresentationAction<PhotoFeature.Action>)
        case sheetPresented

        // MARK: scope (child feature)
        case naverMap(NaverMapFeature.Action)
    }
    
    public init() {}
    
    @Dependency(\.locationManagerClient) var locationManagerClient
    
    public var body: some Reducer<State, Action> {
        // MARK: scope (child feature)
        Scope(state: \.naverMap, action: \.naverMap) { NaverMapFeature() }
        
        BindingReducer()

        Reduce { state, action in
            switch action {
                // MARK: view
            case .onAppear:
                return .send(.onCurrentLocation)
                
                // MARK: navigation
            case .onTapSetting:
                return .none
                
            case let .onChangeBubbleKeywordKind(keyword):
                return .send(.naverMap(.onChangeKeyword(keyword)))
            case .onCurrentLocation:
                return .run { [locationManagerClient] send in
                    let location = try await locationManagerClient.fetchLocation()
                    let position = "\(location?.latitude ?? 37.565493),\(location?.longitude ?? 126.978093)"
                    await send(.naverMap(.onChangePosition(position)))
                }
                
                // MARK: popup
            case let .onPopupButtonTapped(isPresented):
                state.isPopupPresented = isPresented
                return .none
            case let .onSheetButtonTapped(isPresented):
                state.isSheetPresented = isPresented
                return .none
            case let .onMarkerTapped(isPresented):
                state.isMarkerPresented = isPresented
                return .none
                
                // MARK: present
            case let .onMenuButtonTapped(isPresented):
                state.isMenuPresented = isPresented
                return .none
                
                // MARK: sheet
            case .sheetPresented:
                state.sheet = PhotoFeature.State.init()
                return .none
            case .sheet(.dismiss):
                return .none
            case .sheet(.presented(.closeButtonTapped)):
                state.sheet = nil
                return .none

                // MARK: scope (child feature)
            case let .naverMap(action):
                switch action {
                case let .onChangeSelectedMarkerData(data):
                    state.selectedMarkerData = data
                    return .none
                case let .onMarkerTapped(isPresented):
                    state.isMarkerPresented = isPresented
                    return .none
                case let .onChangeKeyword(keyword):
                    state.keyword = keyword
                    return .none
                default: return.none
                }
                
                // MARK: 하단 필수
            case .binding:
                return .none
            case .sheet:
                return .none
            }
        }
        .ifLet(\.$sheet, action: \.sheet) {
            PhotoFeature()
        }
    }
}
