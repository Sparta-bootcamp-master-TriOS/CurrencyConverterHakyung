//
//  UserStateRepository.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

protocol UserStateRepository {
    func getState() -> UserState
    func updateLastViewURI(_ uri: String)
    func getLastViewURI() -> String?
}
