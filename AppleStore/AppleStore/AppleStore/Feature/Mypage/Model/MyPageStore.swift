//
//  MyPageStore.swift
//  AppleStore
//
//  Created by cha_nyeong on 2023/09/13.
//

import SwiftUI
import Firebase
import Combine


class MyPageStore: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriber()
    }
    
    private func setupSubscriber() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
                self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
