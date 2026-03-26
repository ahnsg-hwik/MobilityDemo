//
//  Networking.swift
//  NetworkPlatform
//
//  Created by iOS_Hwik on 12/19/25.
//

import Foundation
import Moya

enum NetworkError: String, Error {
    case unauthorized = "Unable to authenticate user. An error occurred during authorization, please check your connection and try again."
    case unavailableServer = "Server is unavailable"
    case badRequest = "Bad Request"
}

final class NetworkingAPI {
    static let shared: NetworkingAPI = NetworkingAPI()
    
    var provider: Moya.MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(session: Session(interceptor: AuthInterceptor.shared))) {
        self.provider = provider
    }
    
    /// 네트워크 요청 및 응답 데이터 반환
    ///
    /// withCheckedThrowingContinuation를 이용하여 callBack 비동기 함수를 async/await으로 변환
    /// 쉽게 말해 "completion handler" 스타일 코드를 async throws 함수로 래핑
    ///
    /// resume()
    /// - continuation.resume(returning: responseData)
    /// - continuation.resume(throwing: NetworkError.networkError)
    ///
    /// - Parameter target: EndPoint (TargetType)
    /// - Returns: 함수 호출의 리턴값 타입 추론 한 data
    func request<T: Decodable>(_ target: MultiTarget) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            self.provider.request(target) { response in
                switch response {
                case .success(let result):
                    do {
                        let responseData = try JSONDecoder().decode(T.self, from: result.data)
                        continuation.resume(returning: responseData)
                    } catch {
                        continuation.resume(throwing: NetworkError.unavailableServer)
                    }
                case .failure(let error):
                    print("Networking:failure")
                    
                    guard let statusCode = error.response?.statusCode else {
                        continuation.resume(throwing: error)
                        return
                    }

                    switch statusCode {
                    case 401:
                        // TODO: 토큰 만료 로그아웃 작업
                        
                        /* 여러 API 동시 실패 하면 여러번 호출 되어 대응 필요
                        if UserDefaultsManager.shared.isSignIn {
                            UserDefaultsManager.shared.signOut
                            NotificationCenter.default.post(name: .UNAUTHORIZED_SIGNOUT, object: nil)
                        }
                        */

                        continuation.resume(throwing: NetworkError.unauthorized)
                    default:
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
