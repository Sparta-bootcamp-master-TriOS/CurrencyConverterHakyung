//
//  CurrencyMapper.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

import CoreData

struct CurrencyMapper {
    static func toCurrencyEntity(from dto: Currency, context: NSManagedObjectContext) {
        let rates = dto.rates
        let newData = Date(timeIntervalSince1970: dto.timeLastUpdateUnix)

        for (countryCode, rate) in rates {
            // countryCode 기준으로 기존 데이터 fetch
            let fetchRequest: NSFetchRequest<CurrencyEntity> = CurrencyEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "countryCode == %@", countryCode)
            
            let exist = (try? context.fetch(fetchRequest))?.first
            
            // 기존 값 있으면 업데이트, 없으면 새로 생성
            if let entity = exist {
                let calendar = Calendar.current
                let isSameDay = calendar.isDate(entity.updatedDate, inSameDayAs: newData)
                
                if !isSameDay {
                    entity.oldRate = rate
                    entity.updatedDate = newData
                }
            } else {
                let entity = CurrencyEntity(context: context)
                entity.countryCode = countryCode
                entity.oldRate = rate
                entity.updatedDate = newData
                entity.isBookmarked = false
            }
        }
    }
}
