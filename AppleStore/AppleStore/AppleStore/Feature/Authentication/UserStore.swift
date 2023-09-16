//
//  UserStore.swift
//  AppleStore
//
//  Created by 윤해수 on 2023/09/06.
//

import Foundation

///사용자 모델
public struct User: Identifiable, Codable {
    
    public let id: String
    /// 유저의 Auth 고유 아이디.
    public var uid: String
    /// 유저 이름
    public var userName: String
    /// 이메일
    public var email: String
    /// 프로필
    public var imageURLString: String?
    /// 우편번호
    var postal: String?
    /// 주소
    public var headAddress: String?
    /// 상세주소
    public var detailAddress: String?
    /// 국가
    public var nation: String?
    /// 핸드폰
    public var phone: String?
  
    
    init(id: String = UUID().uuidString, uid: String, userName: String, email: String, imageURLString: String? = nil, postal: String? = nil, headAddress: String? = nil, detailAddress: String? = nil, nation: String? = nil, phone: String? = nil) {
        self.id = id
        self.uid = uid
        self.userName = userName
        self.email = email
        self.imageURLString = imageURLString
        self.postal = postal
        self.headAddress = headAddress
        self.detailAddress = detailAddress
        self.nation = nation
        self.phone = phone
    }
    
}
