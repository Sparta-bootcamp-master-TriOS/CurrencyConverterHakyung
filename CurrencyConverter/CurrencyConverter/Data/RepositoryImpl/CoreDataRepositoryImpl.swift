//
//  CoreDataRepositoryImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

final class CoreDataRepositoryImpl: CoreDataRepository {
    
    private let coreDataSource: CoreDataSource
    
    init(coreDataSource: CoreDataSource) {
        self.coreDataSource = coreDataSource
    }
    
    func fetchAll() throws -> CurrencyDomain? {
        let allData = try self.coreDataSource.fetchAll()
        
        let currencyData = allData.reduce(into: [String: CurrencyItemDom]()) { result, entity in
            let item = CurrencyItemDom(
                countryName: "",
                rate: -1.0,
                baseCode: "",
                
                // CoreData
                isBookmarked: entity.isBookmarked
            )
            result[entity.countryCode] = item
        }
        
        return CurrencyDomain(currencyData: currencyData)
    }
    
    func exits(countryCode: String) throws -> Bool {
        try self.coreDataSource.exits(countryCode: countryCode)
    }
    
    func insert(countryCode: String) throws {
        try self.coreDataSource.insert(countryCode: countryCode)
    }
    
    func toggleBookmark(countryCode: String) throws {
        try self.coreDataSource.toggleBookmark(for: countryCode)
    }
}
