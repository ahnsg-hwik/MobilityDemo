//
//  DependencyValues+AllRepository.swift
//  Data
//
//  Created by iOS_Hwik on 4/9/26.
//

import ComposableArchitecture

extension DependencyValues {
    public mutating func setAllRepository() {
        self.picsumRepositoryClient = .live
    }
}
