//
//  NaverMapPolygon.swift
//  Feature
//
//  Created by iOS_Hwik on 1/7/26.
//

import NMapsMap

import Domain

public struct NaverMapPolygon {
    private var onTap: ((MAP_AREA) -> Void)?

    func makePolygon() -> NMFPolygonOverlay {
        return NMFPolygonOverlay()
    }
    
    // MARK: updatePolygon
    
    func updatePolygon(_ polygonOverlay: NMFPolygonOverlay, serviceArea: ServiceArea, mapView: NMFMapView) {
        let basePolygon = NMGPolygon(ring: NMGLineString(points: [
            NMGLatLng(lat: 20.0, lng: 110.0),
            NMGLatLng(lat: 50.0, lng: 110.0),
            NMGLatLng(lat: 50.0, lng: 140.0),
            NMGLatLng(lat: 20.0, lng: 140.0),
            NMGLatLng(lat: 20.0, lng: 110.0),
        ]), interiorRings: makeLineStrings(serviceArea))
        
        polygonOverlay.polygon = basePolygon
        polygonOverlay.fillColor = UIColor(red: 0.161, green: 0.165, blue: 0.169, alpha: 0.5)
        polygonOverlay.outlineColor = UIColor(red: 0.161, green: 0.165, blue: 0.169, alpha: 1)
        polygonOverlay.outlineWidth = 1
        
        polygonOverlay.touchHandler = { _ in
            onTap?(.NON_SERVICE_AREA)
            
            // false 반환 (권장): 오버레이가 이벤트를 처리한 후에도 지도로 이벤트를 전달
            // true 반환: 오버레이가 이벤트를 소비한 것으로 간주하여 지도의 탭 이벤트가 발생하지 않음
            return false
        }
        
        polygonOverlay.mapView = mapView
    }
    
    func makeLineStrings(_ serviceArea: ServiceArea) -> [NMGLineString<AnyObject>] {
        var serviceRings = [NMGLineString<AnyObject>]()
        for fence in serviceArea.geofences {
            var coords = [NMGLatLng]()
            for det in fence.details {
                coords.append(NMGLatLng(lat: det.lat, lng: det.lon))
            }
            let nmgLineString = NMGLineString(points: coords)
            
            serviceRings.append(nmgLineString as! NMGLineString<AnyObject>)
        }
        return serviceRings
    }
    
    // MARK: updateExceptionPolygon
    
    func updateExceptionPolygon(serviceArea: ServiceArea, mapView: NMFMapView) -> [NMFPolygonOverlay] {
        var polygonOverlays = [NMFPolygonOverlay]()
        
        for fence in serviceArea.geofences {
            var polygonOverlay: NMFPolygonOverlay?
            
            switch serviceArea.geofenceTypeCD {
            case .NON_SERVICE_AREA:
                polygonOverlay = returnGetOverlay(fence.details, zindex: -200000, color: UIColor(red: 0.161, green: 0.165, blue: 0.169, alpha: 1))
            default:
                polygonOverlay = returnGetOverlay(fence.details, zindex: -199999, color: UIColor(red: 1.000, green: 0.271, blue: 0.271, alpha: 1))
            }
            
            if let polygonOverlay = polygonOverlay {
                polygonOverlay.touchHandler = { _ in
                    onTap?(serviceArea.geofenceTypeCD)
                    
                    // false 반환 (권장): 오버레이가 이벤트를 처리한 후에도 지도로 이벤트를 전달
                    // true 반환: 오버레이가 이벤트를 소비한 것으로 간주하여 지도의 탭 이벤트가 발생하지 않음
                    return false
                }
                
                polygonOverlays.append(polygonOverlay)
                polygonOverlay.mapView = mapView
            }
        }
        
        return polygonOverlays
    }
    
    func returnGetOverlay(_ details: [GeofenceDetail], zindex: Int, color: UIColor) -> NMFPolygonOverlay? {
        let coords = details.map { NMGLatLng(lat: $0.lat, lng: $0.lon) }
        let polygon = NMGPolygon(ring: NMGLineString(points: coords))
        let polygonOverlay = NMFPolygonOverlay(polygon as! NMGPolygon<AnyObject>)
        
        polygonOverlay?.globalZIndex = zindex
        polygonOverlay?.fillColor = color.withAlphaComponent(0.55)
        polygonOverlay?.outlineColor = color
        polygonOverlay?.outlineWidth = 1
        
        return polygonOverlay
    }
}

extension NaverMapPolygon {
    public func onTap(perform action: @escaping (MAP_AREA) -> Void) -> Self {
        var new = self
        new.onTap = action
        return new
    }
}
