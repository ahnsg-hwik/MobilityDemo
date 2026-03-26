//
//  NaverMapMarker.swift
//  Main
//
//  Created by iOS_Hwik on 12/19/25.
//

import Foundation
import NMapsMap
import Util

public struct NaverMapMarker {
    var position: CLLocationCoordinate2D
    
    var image: (() -> UIImage)?
    var captionText: String?
    var zIndex: Int = 0
    var anchor: CGPoint = .init(x: 0.5, y: 1)
    var onTap: (() -> Void)?
    
    public init(position: CLLocationCoordinate2D) {
        self.position = position
    }
    
    func makeMarker(_ mapView: NMFMapView) -> NMFMarker {
        let marker = NMFMarker()
        updateMarker(marker, mapView)
        return marker
    }

    func updateMarker(_ marker: NMFMarker, _ mapView: NMFMapView) {
        Task {
            await MainActor.run {
                marker.position = NMGLatLng(lat: position.latitude, lng: position.longitude)
                if let image = image {
                    marker.iconImage = NMFOverlayImage(image: image())
                }
                marker.captionText = captionText ?? ""
                marker.touchHandler = { _ in
                    self.onTap?()
                    return true
                }
                
                marker.isHideCollidedSymbols = false
                marker.isHideCollidedCaptions = false
                marker.isHideCollidedMarkers = false
                
                marker.zIndex = zIndex
                marker.anchor = anchor
                marker.mapView = mapView
            }
        }
    }
}

extension NaverMapMarker {
    public func image(_ image: @escaping () -> UIImage) -> Self {
        var new = self
        new.image = image
        return new
    }
    
    public func captionText(_ captionText: String) -> Self {
        var new = self
        new.captionText = captionText
        return new
    }
    
    public func onTap(perform action: @escaping () -> Void) -> Self {
        var new = self
        new.onTap = action
        return new
    }
    
    public func anchor(_ point: CGPoint) -> Self {
        var new = self
        new.anchor = point
        return new
    }
    
    public func zIndex(_ zIndex: Int) -> Self {
        var new = self
        new.zIndex = zIndex
        return new
    }
}
