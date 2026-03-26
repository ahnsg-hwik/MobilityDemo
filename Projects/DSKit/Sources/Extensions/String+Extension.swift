//
//  String+Extension.swift
//  DSKit
//
//  Created by iOS_Hwik on 2/23/26.
//

import SwiftUI

public extension String {
    init(localizedKey: String.LocalizationValue) {
        self.init(localized: localizedKey, bundle: .module)
    }
    
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
