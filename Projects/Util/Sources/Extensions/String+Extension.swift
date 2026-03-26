//
//  String+Extension.swift
//  Util
//
//  Created by iOS_Hwik on 1/7/26.
//

import CoreLocation

extension String {
    public var toCLLocationCoordinate2D: CLLocationCoordinate2D? {
        let components = self.components(separatedBy: ",")
        guard components.count == 2,
              let latitude = Double(components[0]),
              let longitude = Double(components[1]) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
