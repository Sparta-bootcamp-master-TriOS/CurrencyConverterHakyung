//
//  CurrencyEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by kingj on 4/22/25.
//
//

import Foundation
import CoreData


extension CurrencyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyEntity> {
        return NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity")
    }

    @NSManaged public var countryCode: String
    @NSManaged public var isBookmarked: Bool
    @NSManaged public var oldRate: Double
    @NSManaged public var updatedDate: Date
    @NSManaged public var currentRate: Double

}

extension CurrencyEntity : Identifiable {

}
