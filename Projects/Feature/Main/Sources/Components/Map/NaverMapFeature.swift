//
//  NaverMapFeature.swift
//  Feature
//
//  Created by iOS_Hwik on 3/20/26.
//

import ComposableArchitecture

import Domain

@Reducer
public struct NaverMapFeature {
    @ObservableState
    public struct State {
        var position: String = ""
        var keyword: BubbleKeywordKind = .kickboard
        var serviceAreaGroup: ServiceAreaGroup?
        var zoomLevel: Double = 0
        var level: Int = 0
        var markerData: MarkerData = .init()
        var selectedMarkerData: (any Markable)?
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case onChangePosition(String)
        case onChangeKeyword(BubbleKeywordKind)
        case onChangeZoomLevel(Double)
        case onChangeSelectedMarkerData((any Markable)?)
        
        //
        case onMarkerTapped(Bool)

        // MARK: api
        case fetchServiceArea
        case fetchFMSAPi
        case fetchFMSEquipments
        case fetchFMSClustering
        case fetchSpot
        case fetchPoi
        
        case serviceAreaGroupResponse(ServiceAreaGroup?)
        case fmsEquipmentsResponse([Mobility])
        case fmsClusteringLevel1Response([LocationModel])
        case fmsClusteringLevel2Response([LocationModel])
        case spotResponse([Spot])
        case poiResponse([PoiItem])
    }
    
    public init() {}
    
    @Dependency(\.mainClient) var mainClient
    
    @Dependency(\.mapAreaUseCaseClient) var mapAreaUseCaseClient
    @Dependency(\.fmsUseCaseClient) var fmsUseCaseClient
    @Dependency(\.spotUseCaseClient) var spotUseCaseClient
    @Dependency(\.poiUseCaseClient) var poiUseCaseClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .merge(
                    .send(.fetchServiceArea),
                    .send(.fetchSpot)
                )
            case let .onChangePosition(position):
                state.position = position
                return .none
            case let .onChangeKeyword(keyword):
                state.keyword = keyword
                switch keyword {
                case .kickboard, .bike:
                    return .send(.fetchFMSAPi)
                default:
                    if state.markerData.poi.isEmpty { return .send(.fetchPoi) }
                    return .none
                }
            case let .onChangeZoomLevel(zoomLevel):
                state.zoomLevel = zoomLevel
                return .none
            case let .onChangeSelectedMarkerData(data):
                state.selectedMarkerData = data
                return .none
                
                //
            case .onMarkerTapped:
                return .none
                
                // MARK: api
            case .fetchServiceArea:
                return .run { send in
                    let response = try await mapAreaUseCaseClient.fetchServiceArea()
                    await send(.serviceAreaGroupResponse(response))
                }
            case .fetchFMSAPi:
                let clusteringPoint1: Double = 12
                let clusteringPoint2: Double = 10
                state.level = 0
                
                if state.zoomLevel > clusteringPoint1 {
                    return .send(.fetchFMSEquipments)
                } else if state.zoomLevel > clusteringPoint2 {
                    state.level = 1
                } else {
                    state.level = 2
                }
                
                return .send(.fetchFMSClustering)
            case .fetchFMSEquipments:
                return .run { [keyword = state.keyword] send in
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
                let level = state.level
                let keyword = state.keyword
                
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
                    if state.level == 1 {
                        return .send(.fmsClusteringLevel1Response(state.markerData.fmsClusteringLevel1))
                    } else {
                        return .send(.fmsClusteringLevel2Response(state.markerData.fmsClusteringLevel2))
                    }
                }
            case .fetchSpot:
                return .run { send in
                    let response = try await spotUseCaseClient.fetchSpots()
                    await send(.spotResponse(response))
                }
            case .fetchPoi:
                return .run { send in
                    let response = try await poiUseCaseClient.fetchPois()
                    await send(.poiResponse(response))
                }
            case let .serviceAreaGroupResponse(areaGroup):
                state.serviceAreaGroup = areaGroup
                return .none
            case let .fmsEquipmentsResponse(items):
                state.markerData.fmsEquipment = items
                return .none
            case let .fmsClusteringLevel1Response(items):
                state.markerData.fmsClusteringLevel1 = items
                return .none
            case let .fmsClusteringLevel2Response(items):
                state.markerData.fmsClusteringLevel2 = items
                return .none
            case let .spotResponse(items):
                state.markerData.spot = items
                return .none
            case let .poiResponse(items):
                state.markerData.poi = items
                return .none
            }
        }
    }
}
