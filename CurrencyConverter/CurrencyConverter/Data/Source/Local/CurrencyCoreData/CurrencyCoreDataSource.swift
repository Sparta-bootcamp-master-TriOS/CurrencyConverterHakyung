//
//  CurrencyCoreData.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

import CoreData

final class CurrencyCoreDataSource {
    
    private let context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // CoreData의 모든 데이터 불러오기
    func fetchAll() throws -> [CurrencyEntity] {
        do {
            return try self.context.fetch(CurrencyEntity.fetchRequest())
        } catch {
            throw CurrencyCoreDataError.fetchFailed
        }
    }
    
    // CoreData에 해당 countryCode가 존재하는지 확인
    func exits(countryCode: String) throws -> Bool {
        let request = CurrencyEntity.fetchRequest()
        request.predicate = NSPredicate(format: "countryCode == %@", countryCode)
        let count = try self.context.count(for: request)
        return count > 0
    }
    
    // CoreData에 해당 countryCode 데이터 삽입 (초기화)
    func insert(countryCode: String) throws {
        let entity = CurrencyEntity(context: self.context)
        entity.countryCode = countryCode
        entity.isBookmarked = false
        try context.save()
    }
    
    // CoreData의 Bookmark 값 변경하기
    func toggleBookmark(for countryCode: String) throws {
        let request = CurrencyEntity.fetchRequest()
        request.predicate = NSPredicate(format: "countryCode == %@", countryCode)
        
        do {
            let result = try self.context.fetch(request)
            guard let currency = result.first else {
                throw CurrencyCoreDataError.fetchFailed
            }
            
            currency.isBookmarked.toggle()
            try self.context.save()
            
        } catch let error as CurrencyCoreDataError {
            throw error
        } catch {
            throw CurrencyCoreDataError.saveFailed
        }
    }
}
