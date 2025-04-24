//
//  CoreDataRepositoryImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

import Foundation

final class CurrencyCoreDataRepositoryImpl: CurrencyCoreDataRepository {
    
    private let coreDataSource: CurrencyCoreDataSource
    
    init(coreDataSource: CurrencyCoreDataSource) {
        self.coreDataSource = coreDataSource
    }
    
    func fetchAll() throws -> CurrencyDomain? {
        let coreData = try self.coreDataSource.fetchAll()
        
        let currencyData = coreData.reduce(into: [String: CurrencyItemDom]()) { result, entity in
            let item = CurrencyItemDom(
                countryName: "",
                rate: -1.0,
                baseCode: "",
                
                // CoreData
                isBookmarked: entity.isBookmarked,
                updatedDate: entity.updatedDate,
                oldRate: entity.oldRate,
                newDate: Date()
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
