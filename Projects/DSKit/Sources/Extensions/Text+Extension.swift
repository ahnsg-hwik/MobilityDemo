//
//  Text+Extension.swift
//  DSKit
//
//  Created by iOS_Hwik on 2/23/26.
//

import Foundation
import SwiftUI

public extension Text {
    init(_ localizedKey: LocalizedStringKey) {
        self.init(localizedKey, bundle: .module)
    }
}
