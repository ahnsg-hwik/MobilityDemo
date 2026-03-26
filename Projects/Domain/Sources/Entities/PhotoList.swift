//
//  PhotoList.swift
//  Domain
//
//  Created by iOS_Hwik on 12/22/25.
//

import Foundation

public struct PhotoList: Codable, Sendable {
    public let id, author: String
    public let width, height: Int
    public let url, download_url: String
    
    public init(id: String, author: String, width: Int, height: Int, url: String, download_url: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.download_url = download_url
    }
}

public typealias Photos = [PhotoList]
