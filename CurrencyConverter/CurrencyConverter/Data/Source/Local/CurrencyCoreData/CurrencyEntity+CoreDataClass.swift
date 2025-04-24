//
//  CurrencyEntity+CoreDataClass.swift
//  CurrencyConverter
//
//  Created by kingj on 4/22/25.
//
//

import Foundation
import CoreData

@objc(CurrencyEntity)
public class CurrencyEntity: NSManagedObject {
    
    public static let className = "CurrencyEntity"
    
    public enum Key {
        static let countryCode = "countryCode"
        static let isBookmarked = "isBookmarked"
        static let rate = "rate"
        static let updatedDate = "updatedDate"
        static let currentRate = "currentRate"
    }
}
