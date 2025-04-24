//
//  UserStateDataSource.swift
//  CurrencyConverter
//
//  Created by kingj on 4/24/25.
//

import Foundation
import CoreData

final class UserStateDataSource {
    
    private let context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getState() -> UserState {
        let request = UserState.fetchRequest()
        let result = (try? context.fetch(request)) ?? []
        return result.first ?? UserState(context: context)
    }
    
    func updateLastViewURI(_ uri: String) {
        let state = getState()
        state.lastViewURI = uri
        try? context.save()
    }
    
    func getLastViewURI() -> String? {
        return getState().lastViewURI
    }
}
