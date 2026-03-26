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
        var mapData: MapData = .init()
        var markerData: MarkerData = .init()
        var selectedMarkerData: (any Markable)?
        
        // MARK: popup
        var isPopupPresented = false
        var isSheetPresented = false
        var isMarkerPresented = false
        
        // MARK: present
        var isMenuPresented = false
        @Presents var sheet: PhotoFeature.State?

        public init() {}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        // MARK: View
        case onAppear
        
        // MARK: Navigation
        case onTapSetting
        
        // MARK: map
        case onChangeMapViewData(MapData)
        case onChangePosition(String)
        case onChangeLineCoordinates([String])
        case onChangeBubbleKeywordKind(BubbleKeywordKind)
        case onChangeServiceAreaGroup(ServiceAreaGroup?)
        case onChangeZoomLevel(Double)
        
        case onChangeSelectedMarkerData((any Markable)?)
        case onCurrentLocation

        // MARK: popup
        case onPopupButtonTapped(Bool)
        case onSheetButtonTapped(Bool)
        case onMarkerTapped(Bool)
        
        // MARK: present
        case onMenuButtonTapped(Bool)
        case sheet(PresentationAction<PhotoFeature.Action>)
        case showSheet
        
        // MARK: api
        case fetchFMSAPi
        case fetchServiceArea
        case fetchFMSEquipments
        case fetchFMSClustering
        case fetchSpot
        case fetchPoi
        
        case fmsEquipmentsResponse([Mobility])
        case fmsClusteringLevel1Response([LocationModel])
        case fmsClusteringLevel2Response([LocationModel])
        case SpotResponse([Spot])
        case PoiResponse([PoiItem])
        
        case testAction
    }
    
    public init() {}
    
    @Dependency(\.mainClient) var mainClient
    @Dependency(\.locationManagerClient) var locationManagerClient
    
    @Dependency(\.mapAreaUseCaseClient) var mapAreaUseCaseClient
    @Dependency(\.fmsUseCaseClient) var fmsUseCaseClient
    @Dependency(\.spotUseCaseClient) var spotUseCaseClient
    @Dependency(\.poiUseCaseClient) var poiUseCaseClient
    
    public var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                // MARK: View
            case .onAppear:
                return .merge(
                    .send(.onCurrentLocation),
                    .send(.fetchServiceArea),
                    .send(.fetchSpot)
                )
                
                // MARK: Navigation
            case .onTapSetting:
                return .none
                
                // MARK: map
            case let .onChangeMapViewData(data):
                state.mapData = data
                return .none
            case let .onChangePosition(position):
                state.mapData.position = position
                return .none
            case let .onChangeLineCoordinates(lineCoordinates):
                state.mapData.lineCoordinates = lineCoordinates
                return .none
            case let .onChangeBubbleKeywordKind(keyword):
                state.mapData.keyword = keyword
                switch keyword {
                case .kickboard, .bike:
                    return .send(.fetchFMSAPi)
                default:
                    if state.markerData.poi.isEmpty { return .send(.fetchPoi) }
                    return .none
                }
            case let .onChangeServiceAreaGroup(areaGroup):
                state.mapData.serviceAreaGroup = areaGroup
                return .none
            case let .onChangeZoomLevel(zoomLevel):
                state.mapData.zoomLevel = zoomLevel
                return .none
                
            case let .onChangeSelectedMarkerData(data):
                state.selectedMarkerData = data
                return .none
            case .onCurrentLocation:
                return .run { [locationManagerClient] send in
                    let location = try await locationManagerClient.fetchLocation()
                    await send(.onChangePosition("\(location?.latitude ?? 37.55637),\(location?.longitude ?? 126.969726)"))
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
            case .showSheet:
                state.sheet = PhotoFeature.State.init()
                return .none
            case .sheet(.dismiss):
                return .none
            case .sheet(.presented(.closeButtonTapped)):
                state.sheet = nil
                return .none
                
                // MARK: api
            case .fetchFMSAPi:
                if !state.mapData.keyword.isMobility { return .none }
                
                let clusteringPoint1: Double = 12
                let clusteringPoint2: Double = 10
                state.mapData.level = 0
                
                if state.mapData.zoomLevel > clusteringPoint1 {
                    return .send(.fetchFMSEquipments)
                } else if state.mapData.zoomLevel > clusteringPoint2 {
                    state.mapData.level = 1
                } else {
                    state.mapData.level = 2
                }
                
                return .send(.fetchFMSClustering)
            case .fetchServiceArea:
                return .run { send in
                    let response = try await mapAreaUseCaseClient.fetchServiceArea()
                    await send(.onChangeServiceAreaGroup(response))
                }
            case .fetchFMSEquipments:
                return .run { [keyword = state.mapData.keyword] send in
                    let mobilityType: MobilityType? = {
                        switch keyword {
                        case .kickboard: return .kickboard
                        case .bike:      return .bike
                        default:         return nil
                        }
                    }()
                    
                    if let type = mobilityType {
                        let response = try await fmsUseCaseClient.fetchFMSEquipments(type)
                        await send(.fmsEquipmentsResponse(response))
                    }
                }
            case .fetchFMSClustering:
                let level = state.mapData.level
                let keyword = state.mapData.keyword
                
                if mainClient.updateClustering(level, keyword) {
                    return .run { send in
                        let response = try await fmsUseCaseClient.fetchFMSClustering()
                        if let data = response {
                            mainClient.updateNextTime(data.nextTimeDiff, data.level)
                            let cluster = data.getClusterLocation(of: keyword)
                            if level == 1 {
                                await send(.fmsClusteringLevel1Response(cluster))
                            } else {
                                await send(.fmsClusteringLevel2Response(cluster))
                            }
                        }
                    }
                } else {
                    if state.mapData.level == 1 {
                        return .send(.fmsClusteringLevel1Response(state.markerData.fmsClusteringLevel1))
                    } else {
                        return .send(.fmsClusteringLevel2Response(state.markerData.fmsClusteringLevel2))
                    }
                }
            case .fetchSpot:
                return .run { send in
                    let response = try await spotUseCaseClient.fetchSpots()
                    await send(.SpotResponse(response))
                }
            case .fetchPoi:
                return .run { send in
                    let response = try await poiUseCaseClient.fetchPois()
                    await send(.PoiResponse(response))
                }
                
            case let .fmsEquipmentsResponse(items):
                state.markerData.fmsEquipment = items
                return .none
            case let .fmsClusteringLevel1Response(items):
                state.markerData.fmsClusteringLevel1 = items
                return .none
            case let .fmsClusteringLevel2Response(items):
                state.markerData.fmsClusteringLevel2 = items
                return .none
            case let .SpotResponse(items):
                state.markerData.spot = items
                return .none
            case let .PoiResponse(items):
                state.markerData.poi = items
                return .none
                
                // MARK: 나머지
            case .binding(_):
                return .none
            case .sheet:
                return .none
                
            case .testAction:
                return .none
            }
        }
        .ifLet(\.$sheet, action: \.sheet) {
            PhotoFeature()
        }
    }
}
