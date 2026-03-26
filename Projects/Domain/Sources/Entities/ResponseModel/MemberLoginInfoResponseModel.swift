//
//  MemberLoginInfoResponseModel.swift
//  Domain
//
//  Created by iOS_Hwik on 2/2/26.
//

public struct MemberLoginInfoResponseModel: Codable {
    public var resultCode: String?
    public var resultMessage: String?
    public var detailMessage: String?
    public var data: MemberLoginInfo?
}

public struct MemberLoginInfo: Codable {
    public var memberNumber: Int
    public var memberNm: String
    public var token: String
    public var refreshToken: String
    public var memberJoinRt: String
    public var phoneNumberChangeYn: String
}
