//
//  MainFeature.swift
//  Main
//
//  Created by iOS_Hwik on 12/16/25.
//

import ComposableArchitecture

import Domain

@Reducer
public struct MainFeature {
    @ObservableState
    public struct State {
        // MARK: map
        var keyword: BubbleKeywordKind = .kickboard
        var spotDetail: SpotDetail?

        // MARK: popup
        var isPopupPresented = false
        var isSheetPresented = false
        var isMobilityPresented = false
        var isSpotPresented = false
        
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

        // MARK: popup
        case onPopupButtonTapped(Bool)
        case onSheetButtonTapped(Bool)
        case onMobilityTapped(Bool)
        case onSpotTapped(Bool)
        
        // MARK: present
        case onMenuButtonTapped(Bool)
        
        // MARK: sheet
        case sheet(PresentationAction<PhotoFeature.Action>)
        case sheetPresented

        // MARK: scope (child feature)
        case naverMap(NaverMapFeature.Action)
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        // MARK: scope (child feature)
        Scope(state: \.naverMap, action: \.naverMap) { NaverMapFeature() }
        
        BindingReducer()

        Reduce { state, action in
            switch action {
                // MARK: view
            case .onAppear:
                return .none
                
                // MARK: navigation
            case .onTapSetting:
                return .none
                
                // MARK: map
            case let .onChangeBubbleKeywordKind(keyword):
                return .send(.naverMap(.onChangeKeyword(keyword)))
                
                // MARK: popup
            case let .onPopupButtonTapped(isPresented):
                state.isPopupPresented = isPresented
                return .none
            case let .onSheetButtonTapped(isPresented):
                state.isSheetPresented = isPresented
                return .none
            case let .onMobilityTapped(isPresented):
                state.isMobilityPresented = isPresented
                return .none
            case let .onSpotTapped(isPresented):
                state.isSpotPresented = isPresented
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
                case let .onChangeKeyword(keyword):
                    state.keyword = keyword
                    return .none
                case let .spotDetailResponse(item):
                    state.spotDetail = item
                    return .send(.onSpotTapped(true))
                default: return .none
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
