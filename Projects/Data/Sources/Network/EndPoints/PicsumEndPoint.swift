//
//  PicsumEndPoint.swift
//  NetworkPlatform
//
//  Created by iOS_Hwik on 12/22/25.
//

import Foundation
import Moya

enum PicsumEndPoint {
    case photoList
}

extension PicsumEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://picsum.photos")!
    }
    
    var path: String {
        switch self {
        case .photoList:
            return "/v2/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photoList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .photoList:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var validationType: ValidationType { .successCodes }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json;charset=utf-8"]
    }
}
