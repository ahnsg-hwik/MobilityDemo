//
//  AuthInterceptor.swift
//  Data
//
//  Created by iOS_Hwik on 2/2/26.
//

import Foundation

import Alamofire
import ComposableArchitecture

import Domain

// MARK: -

//final class AuthInterceptor: @unchecked Sendable {
//    static let shared: AuthInterceptor = AuthInterceptor()
//    
//    private let lock = NSLock()
//    
//    private var requestsToRetry: [(RetryResult) -> Void] = []
//    private var isRefreshing = false
//    private let retryLimit = 1
//
//    let headers: HTTPHeaders = [
//        "Content-Type": "application/json;charset=utf-8",
//        "Accept-Language": "kr"
//    ]
//
//    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
//        let params: Parameters = [
//            "memberNumber": "",
//            "refreshToken": ""
//        ]
//        
//        AF.request("",
//                   method: .post,
//                   parameters: params,
//                   encoding: JSONEncoding.default,
//                   headers: headers)
//        .validate(statusCode: 200..<400)
//        .responseDecodable(of: MemberLoginInfoResponseModel.self) { response in
//            switch response.result {
//            case .success(let response):
//                if let data = response.data {
//                    print(data)
//                    
//                    // TODO: token save ...
//                    completion(true)
//                } else {
//                    completion(false)
//                }
//            case .failure(_):
//                completion(false)
//            }
//        }
//    }
//}
//
//extension AuthInterceptor: RequestInterceptor {
//    func adapt(_ urlRequest: URLRequest, using state: RequestAdapterState, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
//        print("AuthInterceptor:adapt(_:using:completion):urlRequest: \(urlRequest)")
//
//        // TODO: accessToken
//        let accessToken = ""
//        guard !accessToken.isEmpty else {
//            completion(.success(urlRequest))
//            return
//        }
//
//        var request = urlRequest
//        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
//        completion(.success(request))
//    }
//    
//    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
//        print("AuthInterceptor:retry(_:for:duTo:completion):retryCount: \(request.retryCount)")
//        
//        lock.lock()
//        defer { lock.unlock() }
//
//        guard let response = request.task?.response as? HTTPURLResponse,
//                response.statusCode == 401 else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
// 
//        requestsToRetry.append(completion)
//
//        if !isRefreshing {
//            isRefreshing = true
//
//            if request.retryCount >= retryLimit  {
//                self.requestsToRetry.forEach {
//                    $0(.doNotRetry)
//                }
//                return
//            }
//
//            refreshToken { [weak self] isSuccess in
//                guard let self else { return }
//                
//                lock.lock()
//                defer {
//                    lock.unlock()
//                    requestsToRetry.removeAll()
//                    isRefreshing = false
//                }
//                
//                if isSuccess {
//                    requestsToRetry.forEach { $0(.retry) }
//                } else {
//                    requestsToRetry.forEach { $0(.doNotRetry) }
//                }
//            }
//        }
//    }
//}

// MARK: -

final class AuthInterceptor {
    static let shared: AuthInterceptor = AuthInterceptor()
    
    private let tokenStore = TokenStore()
    private let retryLimit = 1
}

extension AuthInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, using state: RequestAdapterState, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        // TODO: read accessToken
        let accessToken = ""
        guard !accessToken.isEmpty else {
            completion(.success(urlRequest))
            return
        }

        var request = urlRequest
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
                response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
    
        // 무한 루프 방지 (retry 후 401 에러 발생 시)
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        
        Task {
            do {
                _ = try await tokenStore.refreshToken()
                completion(.retry)
            } catch {
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

public actor TokenStore {
    @Dependency(\.memberUseCaseClient) var memberUseCaseClient
    
    // 토큰 갱신 작업
    private var refreshTokenTask: Task<MemberLoginInfo, Error>?
    
    public init() {}

    public func refreshToken() async throws -> MemberLoginInfo {
        if let task = refreshTokenTask {
            // 이전 요청이 있다면 기존 task를 기다려서 반환하기
            return try await task.value
        }
        
        // 들어온 작업이 없다면 새로운 refresh token task 생성
        let task = Task<MemberLoginInfo, Error> {
            // task 끝나면 nil로 초기화
            defer { refreshTokenTask = nil }
            
            // 토큰 갱신
            let result = try await memberUseCaseClient.fetchRefreshToken()
            
            // refreshToken 결과 저장
            await MainActor.run {
                print("Networking:TokenStore:refreshToken: \(result.refreshToken)")
                print("Networking:TokenStore:token: \(result.token)")
            }

            // 갱신된 결과 반환
            return result
        }
        
        // 현재 진행 중인 task 저장 및 반환
        // - 이후에 요청이 또 들어오면 이 작업을 기다림
        refreshTokenTask = task
        return try await task.value // 성공 시 TokenResponse, 실패 시 throw Error
    }
}
