//
//  JSONParser.swift
//  Util
//
//  Created by iOS_Hwik on 1/9/26.
//

import Foundation

public struct JSONParser {
    public static let shared: JSONParser = JSONParser()
    
    func JSONStringEncoder<T: Encodable>(_ value: T) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // 읽기 좋게 정렬 (선택 사항)
        
        let jsonData = try? encoder.encode(value)
        if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        
        return ""
    }
    
    func JSONStringDecoder<T: Decodable>(_ type: T.Type, from jsonString: String) -> Result<T, Error> {
        guard let jsonData = jsonString.data(using: .utf8) else {
            let error = NSError(domain: "DataError", code: -1)
            return .failure(error)
        }

        let decoder = JSONDecoder()

        do {
            let result = try decoder.decode(type, from: jsonData)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
