//
//  MapAreaUseCaseClient.swift
//  Domain
//
//  Created by iOS_Hwik on 1/7/26.
//

import ComposableArchitecture

@DependencyClient
public struct MapAreaUseCaseClient: Sendable {
    public var fetchServiceArea: @Sendable () async throws -> ServiceAreaGroup
}

extension DependencyValues {
    public var mapAreaUseCaseClient: MapAreaUseCaseClient {
        get { self[MapAreaUseCaseKeyClient.self] }
        set { self[MapAreaUseCaseKeyClient.self] = newValue }
    }
}

private enum MapAreaUseCaseKeyClient: DependencyKey {
    public static var liveValue: MapAreaUseCaseClient = {
        return MapAreaUseCaseClient(
            fetchServiceArea: {
                serviceAreaGroup
            }
        )
    }()
    
    public static var previewValue = MapAreaUseCaseClient(
        fetchServiceArea: {
            serviceAreaGroup
        }
    )
}

extension MapAreaUseCaseKeyClient {
    static var serviceAreaGroup = ServiceAreaGroup(
        serviceAvailable: ServiceArea(geofenceTypeCD: .SERVICE_AREA, geofenceTypeCDName: "서비스 가능 지역", geofences: [
            Geofence(serviceRegionID: 1, serviceRegionName: "서울역", geofenceID: 1, details: [
                GeofenceDetail(lat: 37.55414157100609, lon: 126.96896327346775),
                GeofenceDetail(lat: 37.55334913016101, lon: 126.97934062427187),
                GeofenceDetail(lat: 37.54843580885038, lon: 126.98346612100136),
                GeofenceDetail(lat: 37.54314750292694, lon: 126.99093563270101),
                GeofenceDetail(lat: 37.54254227778108, lon: 126.9681817917084),
                GeofenceDetail(lat: 37.55414157100609, lon: 126.96896327346775)
            ]),
            Geofence(serviceRegionID: 2, serviceRegionName: "테스트", geofenceID: 1, details: [
                GeofenceDetail(lat: 37.56614157100609, lon: 126.98096327346775),
                GeofenceDetail(lat: 37.56534913016101, lon: 126.99134062427187),
                GeofenceDetail(lat: 37.56043580885038, lon: 126.99546612100136),
                GeofenceDetail(lat: 37.55514750292694, lon: 127.00293563270101),
                GeofenceDetail(lat: 37.55454227778108, lon: 126.9901817917084),
                GeofenceDetail(lat: 37.56614157100609, lon: 126.98096327346775)
            ])
        ]),
        serviceDisable: ServiceArea(geofenceTypeCD: .NON_SERVICE_AREA, geofenceTypeCDName: "서비스 불가 지역", geofences: [
            Geofence(serviceRegionID: 1, serviceRegionName: "서울역", geofenceID: 1, details: [
                GeofenceDetail(lat: 37.55637476811247, lon: 126.96972658110947),
                GeofenceDetail(lat: 37.55578405798426, lon: 126.97265259420834),
                GeofenceDetail(lat: 37.5489977594225, lon: 126.97087154275685),
                GeofenceDetail(lat: 37.55637476811247, lon: 126.96972658110947),
            ]),
        ]),
        returnDisable: ServiceArea(geofenceTypeCD: .NON_RETURN_AREA, geofenceTypeCDName: "반납 불가 지역", geofences: [
            Geofence(serviceRegionID: 1, serviceRegionName: "서울역", geofenceID: 1, details: [
                GeofenceDetail(lat: 37.54813321841793, lon: 126.97636008906657),
                GeofenceDetail(lat: 37.54749921530825, lon: 126.97603295716733),
                GeofenceDetail(lat: 37.546764341319886, lon: 126.97616017512813),
                GeofenceDetail(lat: 37.546706703837934, lon: 126.97710522283711),
                GeofenceDetail(lat: 37.547528033748385, lon: 126.97723244079792),
                GeofenceDetail(lat: 37.54813321841793, lon: 126.97636008906657),
            ]),
        ])
    )
}
