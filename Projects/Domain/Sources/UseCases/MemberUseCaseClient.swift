//
//  MemberUseCaseClient.swift
//  Domain
//
//  Created by iOS_Hwik on 2/2/26.
//

import ComposableArchitecture

@DependencyClient
public struct MemberUseCaseClient: Sendable {
    public var fetchRefreshToken: @Sendable () async throws -> MemberLoginInfo
}

extension DependencyValues {
    public var memberUseCaseClient: MemberUseCaseClient {
        get { self[MemberUseCaseKeyClient.self] }
        set { self[MemberUseCaseKeyClient.self] = newValue }
    }
}

private enum MemberUseCaseKeyClient: DependencyKey {
    static var liveValue: MemberUseCaseClient = {
        return MemberUseCaseClient(
            fetchRefreshToken: { info }
        )
    }()
    
    static var previewValue = MemberUseCaseClient(
        fetchRefreshToken: { info }
    )
}

extension MemberUseCaseKeyClient {
    static var info = MemberLoginInfo(memberNumber: 0, memberNm: "", token: "token", refreshToken: "refreshToken", memberJoinRt: "", phoneNumberChangeYn: "N")
}
