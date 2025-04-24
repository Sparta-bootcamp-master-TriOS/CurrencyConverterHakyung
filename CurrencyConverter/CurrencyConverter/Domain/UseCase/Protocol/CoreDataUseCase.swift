//
//  CoreDataUseCase.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

protocol CoreDataUseCase {
    func fetchAll() throws -> CurrencyDomain?
    func exits(countryCode: String) throws -> Bool
    func insert(countryCode: String) throws
    func toggleBookmark(countryCode: String) throws
}
