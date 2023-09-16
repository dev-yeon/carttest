//
//  DirectionResponse.swift
//  AppleStore
//
//  Created by 김효석 on 2023/09/11.
//

import Foundation

struct DirectionResponse: Codable {
    let route: Route
}

struct Route: Codable {
    let traoptimal: [Traoptimal]
}

struct Traoptimal: Codable {
    let summary: Summary
    let path: [[Double]]
}

struct Summary: Codable {
    let distance: Int
    let duration: Int
}

