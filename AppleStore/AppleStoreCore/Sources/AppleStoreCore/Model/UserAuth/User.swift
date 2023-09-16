//
//  User.swift
//  AppleStore
//
//  Created by Hyo Myeong Ahn on 2023/09/06.
//

import Foundation

///사용자 모델

public struct User: Identifiable, Codable {
    public var id: String { // id 프로퍼티로 uid 값을 사용  신우진 23.09.13  관리자페이지에서 Identifiable프로토콜이 필요함 Table 쓰려면..
        return uid
    }
    
//    public let id: String
    /// 유저의 Auth 고유 아이디.
    public var uid: String
    /// 유저 이름
    public var userName: String
    /// 이메일
    public var email: String
    /// 프로필
    public var imageURLString: String?
    /// 우편번호
    public var prostal: String?
    /// 주소
    public var headAddress: String?
    /// 상세주소
    public var detailAddress: String?
    /// 국가
    public var nation: String?
    /// 핸드폰
    public var phone: String?


    public init(uid: String, username: String, email: String, imageURLString: String? = nil, prostal: String? = nil, headAddress: String? = nil, detailAddress: String? = nil, nation: String? = nil, phone: String? = nil) {
//        self.id = id
        self.uid = uid
        self.userName = username
        self.email = email
        self.imageURLString = imageURLString
        self.prostal = prostal
        self.headAddress = headAddress
        self.detailAddress = detailAddress
        self.nation = nation
        self.phone = phone
    }

}
