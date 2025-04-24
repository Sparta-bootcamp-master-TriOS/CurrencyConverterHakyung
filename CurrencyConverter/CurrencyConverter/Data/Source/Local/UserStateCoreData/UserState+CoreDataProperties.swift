//
//  UserState+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

import Foundation
import CoreData


extension UserState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserState> {
        return NSFetchRequest<UserState>(entityName: "UserState")
    }

    @NSManaged public var lastViewURI: String?
}

extension UserState : Identifiable {

}
