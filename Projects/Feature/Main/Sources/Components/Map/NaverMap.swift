//
//  NaverMapView.swift
//  Main
//
//  Created by iOS_Hwik on 12/19/25.
//

import SwiftUI
import NMapsMap

import Domain
import Util

public struct NaverMap: UIViewRepresentable {
    @Binding private var data: MapData
    
    private var onMapTap: (() -> Void)?
    private var onMapViewCameraIdle: ((Double) -> Void)?
    
    private var selectedMarkerData: (any Markable)?
    private var markerData: MarkerData
    private var markerContent: ((any Markable, CLLocationCoordinate2D, Bool) -> NaverMapMarker)?
    
    public init(_ data: Binding<MapData>,
                selectedMarkerData: (any Markable)?,
                markerData: MarkerData,
                markerContent: @escaping (any Markable, CLLocationCoordinate2D, Bool) -> NaverMapMarker) {
        self._data = data
        self.selectedMarkerData = selectedMarkerData
        self.markerData = markerData
        self.markerContent = markerContent
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIView(context: Context) -> NMFNaverMapView {
        print("NaverMapView:makeUIView(_:context)")
        
        let view = NMFNaverMapView(frame: .infinite)
        view.showLocationButton = false
        view.showZoomControls = false
        view.showCompass = false
        view.showScaleBar = true
        
        view.mapView.mapType = .basic
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true)
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: true)
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_BICYCLE, isEnabled: true)
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 15.974 // 50m
        view.mapView.minZoomLevel = 8
        
        view.mapView.touchDelegate = context.coordinator
        view.mapView.addCameraDelegate(delegate: context.coordinator)
        
        return view
    }
    
    public func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        print("NaverMapView:updateUIView(_:context)")
        
        updateCamera(uiView.mapView, coordinator: context.coordinator)
        updateSelectedMarker(uiView.mapView, coordinator: context.coordinator)
        updateMarker(uiView.mapView, coordinator: context.coordinator)
        updatePolygon(uiView.mapView, coordinator: context.coordinator)
        updateExceptionPolygon(uiView.mapView, coordinator: context.coordinator)
    }
    
    public class Coordinator: NSObject,
                              NMFMapViewCameraDelegate,
                              NMFMapViewTouchDelegate,
                              CLLocationManagerDelegate,
                              NMFMapViewOptionDelegate {
        
        private var parent: NaverMap
        
        init(_ parent: NaverMap) {
            self.parent = parent
        }
        
        // MARK: marker
        var markers = [AnyHashable: NMFMarker]()
        var selectedMarkers = [AnyHashable: NMFMarker]()
        
        // MARK: polygon
        var infoWindow: NMFInfoWindow = NMFInfoWindow()
        var touchArea: MAP_AREA = MAP_AREA.SERVICE_AREA
        
        var polygonOverlay: NMFPolygonOverlay?
        var polygonOverlays: [NMFPolygonOverlay]?
        var path: NMFPath?
        
        // MARK: NMFMapViewTouchDelegate
        
        public func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            self.parent.onMapTap?()
            openInfoWindow(mapView, didTapMap: latlng)
        }
        
        // MARK: NMFMapViewCameraDelegate

        public func mapViewCameraIdle(_ mapView: NMFMapView) {
            self.parent.onMapViewCameraIdle?(mapView.zoomLevel)
            
            initMapData()
        }
        
        private func initMapData() {
            self.parent.data.position = ""
            self.parent.data.serviceAreaGroup = nil
        }
    }
}

extension NaverMap.Coordinator {
    func openInfoWindow(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng) {
        print("mapTouch: openInfoWindow : touchArea: \(touchArea)")
        
        infoWindow.close()

        switch touchArea {
        case .NON_RETURN_AREA:
            infoWindow.position = latlng
            infoWindow.dataSource = InfoWindowDataSource.NonReturn.getDataSource()
            infoWindow.open(with: mapView)
        case .NON_SERVICE_AREA:
            infoWindow.position = latlng
            infoWindow.dataSource = InfoWindowDataSource.NonServiceArea.getDataSource()
            infoWindow.open(with: mapView)
        default:
            break
        }
        
        touchArea = MAP_AREA.SERVICE_AREA
    }
}

extension NaverMap {
    private func updateCamera(_ mapView: NMFMapView, coordinator: Coordinator) {
        
        guard let locationCooridnate2D = self.data.position.toCLLocationCoordinate2D else { return }
        
        let location = NMGLatLng(lat: locationCooridnate2D.latitude, lng: locationCooridnate2D.longitude)
        let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(location, zoom: mapView.zoomLevel))
        cameraUpdate.animation = .easeIn
        
        mapView.locationOverlay.location = location
        mapView.moveCamera(cameraUpdate)
    }
    
    private func updateSelectedMarker(_ mapView: NMFMapView, coordinator: Coordinator) {
        guard let markerContent = self.markerContent else { return }
        
        guard let item = self.selectedMarkerData else {
            removeSelectedMarker(coordinator: coordinator)
            return
        }
        
        let ids: [AnyHashable] = Array(coordinator.selectedMarkers.keys)
        let position = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
        let content = markerContent(item, position, true)

        if !ids.contains(item.identifiable) {
            removeSelectedMarker(coordinator: coordinator)
            
            let marker = content.makeMarker(mapView)
            coordinator.selectedMarkers[item.identifiable] = marker
        }
    }
    
    /// 선택 마커 삭제
    /// - Parameter coordinator: coordinator
    private func removeSelectedMarker(coordinator: Coordinator) {
        Array(coordinator.selectedMarkers.keys)
            .forEach {
                coordinator.selectedMarkers[$0]?.mapView = nil
                coordinator.selectedMarkers.removeValue(forKey: $0)
            }
    }

    private func updateMarker(_ mapView: NMFMapView, coordinator: Coordinator) {
        guard let markerContent = self.markerContent else { return }
        
        let allItems = self.markerData.filteredItems(for: data.keyword, level: data.level)

        removeMarker(coordinator: coordinator)
        
        let selectedIdsSet = Set(coordinator.selectedMarkers.keys.compactMap { $0 as? String })
        let idsSet = Set(coordinator.markers.keys.compactMap { $0 as? String })
        
        for item in allItems {
            let itemId = item.identifiable

            func hiddenMarker() -> Bool {
                if selectedIdsSet.contains(where: itemId.contains) {
                    coordinator.markers[itemId]?.mapView = nil // mobility 이외 마커 숨김
                    return true // mobility 생성 제한
                }

                if coordinator.markers[itemId]?.mapView == nil {
                    coordinator.markers[itemId]?.mapView = mapView // mobility 이외 마커 표시
                }
                
                return false
            }

            // 선택 마커에 대한 원본 마커 숨김 및 표시
            // - 선택 하고 있는 동안 기기가 이동 하면 마커 위치가 변경 되어 삭제 하지만 이동 해도 상관 없으면 제거
            if hiddenMarker() {
                continue
            }
            
            // create marker
            // - kickboard, bike: mobility 마커 무조건 생성 spot 마커는 상태가 변경될 때만 생성
            // - poi: keyword 변경될 때만 생성
            let position = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            let content = markerContent(item, position, false)
            
            if !idsSet.contains(itemId) {
                let marker = content.makeMarker(mapView)
                coordinator.markers[item.identifiable] = marker
            }
        }
    }
    
    /// 마커 삭제
    /// - Parameter coordinator: coordinator
    private func removeMarker(coordinator: Coordinator) {
        let commonTypes = [String(describing: Mobility.self), String(describing: LocationModel.self)]
        let targetType = (data.keyword == .kickboard || data.keyword == .bike)
            ? String(describing: PoiItem.self)
            : String(describing: Spot.self)
        let searchKeywords = commonTypes + [targetType]
        
        Array(coordinator.markers.keys)
            .compactMap { $0 as? String }
            .filter { id in
                searchKeywords.contains(where: id.contains)
            }
            .forEach {
                coordinator.markers[$0]?.mapView = nil
                coordinator.markers.removeValue(forKey: $0)
            }
    }
    
    
    private func updatePolygon(_ mapView: NMFMapView, coordinator: Coordinator) {
        
        guard let serviceAvailable = self.data.serviceAreaGroup?.serviceAvailable else { return }
        
        coordinator.polygonOverlay?.mapView = nil
        coordinator.polygonOverlay = nil
        
        let content = NaverMapPolygon()
            .onTap { type in
                print("mapTouch: updatePolygon")
                coordinator.touchArea = type
        }
        
        if let polygonOverlay = coordinator.polygonOverlay {
            content.updatePolygon(polygonOverlay, serviceArea: serviceAvailable, mapView: mapView)
        } else {
            let polygonOverlay = content.makePolygon()
            content.updatePolygon(polygonOverlay, serviceArea: serviceAvailable, mapView: mapView)
            coordinator.polygonOverlay = polygonOverlay
        }
    }
    
    private func updateExceptionPolygon(_ mapView: NMFMapView, coordinator: Coordinator) {
        
        guard let serviceDisable = self.data.serviceAreaGroup?.serviceDisable,
              let returnDisable = self.data.serviceAreaGroup?.returnDisable else { return }
        
        coordinator.polygonOverlays?.forEach { $0.mapView = nil }
        coordinator.polygonOverlays = nil
        
        let mpaAreas = [MAP_AREA.NON_SERVICE_AREA, MAP_AREA.NON_RETURN_AREA]
        
        let content = NaverMapPolygon()
            .onTap { type in
                print("mapTouch: updateExceptionPolygon")
                coordinator.touchArea = type
        }

        for type in mpaAreas {
            let polygonOverlays = content.updateExceptionPolygon(serviceArea: type == .NON_SERVICE_AREA ? serviceDisable : returnDisable, mapView: mapView)
            coordinator.polygonOverlays = coordinator.polygonOverlays ?? [] + polygonOverlays
        }
    }
}

extension NaverMap {
    /// 지도가 탭되면 호출된다.
    /// `NMFMapViewTouchDelegate > mapViewCameraIdle(:)`
    func onMapTap(perform action: @escaping () -> Void) -> Self {
        var new = self
        new.onMapTap = action
        return new
    }
    
    public func onMapViewCameraIdle(action: @escaping (Double) -> Void) -> Self {
        var new = self
        new.onMapViewCameraIdle = action
        return new
    }
}
