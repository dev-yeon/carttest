//
//  WWDCViewModel.swift
//  test01
//
//  Created by yeon on 2023/09/06.
//

import Foundation

struct Session: Identifiable {
  let id = UUID()
  let title: String
}

class WWDCViewModel: ObservableObject {
  @Published private(set) var sessions: [Session] = []
  
  init() {
    self.sessions = getSessions()
  }
  
  private func getSessions() -> [Session] {
    return [
      Session(title: "AR Quick Look, meet Object Capture"),
      Session(title: "ARC in Swift: Basics and beyond"),
      Session(title: "Accelerate networking with HTTP/3 and QUIC"),
      Session(title: "Accessibility by design: An Apple Watch for everyone"),
      Session(title: "Add intelligence to your widgets"),
      Session(title: "Add rich graphics to your SwiftUI app"),
      Session(title: "Add support for Matter in your smart home app"),
      Session(title: "Adopt Quick Note"),
      Session(title: "Analyze HTTP traffic in Instruments"),
      Session(title: "Apple’s privacy pillars in focus")
    ]
  }
}
