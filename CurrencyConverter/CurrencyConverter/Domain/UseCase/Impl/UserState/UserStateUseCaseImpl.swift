//
//  UserStateUseCaseImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

import Foundation

final class UserStateUseCaseImpl: UserStateUseCase {
    
    private let userStateRepository: UserStateRepositoryImpl
    
    init(userStateRepository: UserStateRepositoryImpl) {
        self.userStateRepository = userStateRepository
    }
    
    func getState() -> UserState {
        self.userStateRepository.getState()
    }
    
    func updateLastViewURI(_ uri: String) {
        self.userStateRepository.updateLastViewURI(uri)
    }
    
    func getLastViewURI() -> String? {
        self.userStateRepository.getLastViewURI()
    }
    
    
}
