//
//  PoiUseCaseClient.swift
//  Domain
//
//  Created by iOS_Hwik on 1/14/26.
//

import ComposableArchitecture

@DependencyClient
public struct PoiUseCaseClient: Sendable {
    public var fetchPois: @Sendable () async throws -> [PoiItem]
}

extension DependencyValues {
    public var poiUseCaseClient: PoiUseCaseClient {
        get { self[PoiUseCaseKeyClient.self] }
        set { self[PoiUseCaseKeyClient.self] = newValue }
    }
}

private enum PoiUseCaseKeyClient: DependencyKey {
    static var liveValue: PoiUseCaseClient = {
        return PoiUseCaseClient(
            fetchPois: { pois }
        )
    }()
    
    static var previewValue = PoiUseCaseClient(
        fetchPois: { pois }
    )
}

extension PoiUseCaseKeyClient {
    static var pois = [
        PoiItem(poiID: "1", poiName: "임자도", lat: 37.552601, lon: 126.990989, hwikCategoryCD: "음식점|생선회", briefDescription: "역곡시장에서 만나는 바다의 신선함"),
        PoiItem(poiID: "2", poiName: "갈비도락 구로항동점", lat: 37.545660, lon: 126.996311, hwikCategoryCD: "음식점|육류"),
        PoiItem(poiID: "3", poiName: "치히로 항동수목원점", lat: 37.544435, lon: 127.008327, hwikCategoryCD: "음식점|일식당", briefDescription: "아기자기한 분위기에서 즐기는 한 끼")
    ]
}
