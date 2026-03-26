//
//  HttpBinEndPoint.swift
//  Data
//
//  Created by iOS_Hwik on 2/4/26.
//

import Foundation
import Moya

enum HttpBinEndPoint {
    case auth_bearer
    case auth_status
}

extension HttpBinEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://httpbin.org")!
    }
    
    var path: String {
        switch self {
        case .auth_bearer:
            return "/bearer"
        case .auth_status:
            return "/status/400"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .auth_bearer:
            return .get
        case .auth_status:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .auth_bearer:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .auth_status:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var validationType: ValidationType { .successCodes }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json;charset=utf-8"]
    }
}
