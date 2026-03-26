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
        PoiItem(poiID: "1", poiName: "", lat: 37.552601, lon: 126.990989),
        PoiItem(poiID: "2", poiName: "", lat: 37.545660, lon: 126.996311),
        PoiItem(poiID: "3", poiName: "", lat: 37.544435, lon: 127.008327)
    ]
}
