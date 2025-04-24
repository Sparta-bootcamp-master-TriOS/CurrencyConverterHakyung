//
//  CoreDataUseCaseImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

final class CurrencyCoreDataUseCaseImpl: CurrencyCoreDataUseCase {
    
    private let coreDataRepository: CurrencyCoreDataRepositoryImpl
    
    init(coreDataRepository: CurrencyCoreDataRepositoryImpl) {
        self.coreDataRepository = coreDataRepository
    }
    
    func fetchAll() throws -> CurrencyDomain? {
        try self.coreDataRepository.fetchAll()
    }
    
    func exits(countryCode: String) throws -> Bool {
        try self.coreDataRepository.exits(countryCode: countryCode)
    }
    
    func insert(countryCode: String) throws {
        try self.coreDataRepository.insert(countryCode: countryCode)
    }
    
    func toggleBookmark(countryCode: String) throws {
        try self.coreDataRepository.toggleBookmark(countryCode: countryCode)
    }
}
