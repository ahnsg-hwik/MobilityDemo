//
//  LocationImplClient.swift
//  Data
//
//  Created by iOS_Hwik on 1/26/26.
//

import CoreLocation
import ComposableArchitecture

import Domain

extension LocationManagerClient: @retroactive DependencyKey {
    public static let liveValue = LocationManagerClient.live
}

extension LocationManagerClient {
    static var live: Self {
        let location = Location()

        return Self(
            isAuthorization: { location.isAuthorization  },
            checkAuthorization: { location.checkAuthorization() },
            fetchLocation: { location.locationCoordinate },
            delegate: { location.authorizationStream }
        )
    }
}

private final class Location: NSObject {
    private var locationManager = CLLocationManager()
    
    var isAuthorization: Bool {
        let status = locationManager.authorizationStatus
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    var locationCoordinate: CLLocationCoordinate2D? {
        locationManager.requestWhenInUseAuthorization() // 권한 팝업 표시
        locationManager.startUpdatingLocation() // 현재 위치를 지속적으로 요청
        return locationManager.location?.coordinate
    }
    
    private var addToAuthorization: ((LocationManagerClient.DelegateAction) -> Void)?
    
    lazy var authorizationStream: AsyncStream<LocationManagerClient.DelegateAction> = {
        AsyncStream { continuation in
//            continuation.onTermination = { _ in
//            }
            
            addToAuthorization = { action in
                continuation.yield(action)
            }
        }
    }()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() -> Bool {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted:
            locationManager.requestWhenInUseAuthorization() // 권한 팝업 표시
            return false
        default:
            return false
        }
    }
}

extension Location: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        addToAuthorization?(.didChangeAuthorization(manager.authorizationStatus))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
}
