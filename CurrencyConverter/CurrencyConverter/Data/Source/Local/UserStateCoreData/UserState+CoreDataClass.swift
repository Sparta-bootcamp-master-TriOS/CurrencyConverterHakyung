//
//  UserState+CoreDataClass.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

import Foundation
import CoreData

@objc(UserState)
public class UserState: NSManagedObject {
    
    public static let className = "UserState"
    
    public enum Key {
        static let lastViewURI = "lastViewURI"
    }
}
