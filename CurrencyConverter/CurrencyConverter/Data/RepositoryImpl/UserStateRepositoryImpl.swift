//
//  UserStateRepositoryImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

import Foundation

final class UserStateRepositoryImpl: UserStateRepository {
    
    private let userStateDataSource: UserStateDataSource
    
    init(userStateDataSource: UserStateDataSource) {
        self.userStateDataSource = userStateDataSource
    }
    
    func getState() -> UserState {
        self.userStateDataSource.getState()
    }
    
    func updateLastViewURI(_ uri: String) {
        self.userStateDataSource.updateLastViewURI(uri)
    }
    
    func getLastViewURI() -> String? {
        self.userStateDataSource.getLastViewURI()
    }
    
    
}
