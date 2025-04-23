//
//  CoreDataUseCaseImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

final class CoreDataUseCaseImpl: CoreDataUseCase {
    
    private let coreDataRepository: CoreDataRepositoryImpl
    
    init(coreDataRepository: CoreDataRepositoryImpl) {
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
