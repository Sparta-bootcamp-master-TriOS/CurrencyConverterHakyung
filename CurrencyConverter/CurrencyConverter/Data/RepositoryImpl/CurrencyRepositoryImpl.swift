//
//  CurrencyRepositoryImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import Foundation
import Alamofire
import CoreData

final class CurrencyRepositoryImpl: CurrencyRepository {
    
    private let currencyDataSource: CurrencyDataSource
    private let context: NSManagedObjectContext
    
    init(
        currencyDataSource: CurrencyDataSource,
        context: NSManagedObjectContext
    ) {
        self.currencyDataSource = currencyDataSource
        self.context = context
    }
    
    func fetchCurrency(completion: @escaping (Result<Currency, CurrencyError>) -> Void) {
        let urlComponents = URLComponents(string: "https://open.er-api.com/v6/latest/USD")

        guard let url = urlComponents?.url else {
            completion(.failure(CurrencyError.network))
            return
        }
        
        currencyDataSource.fetchData(url: url) { result in
            completion(result)
        }
    }
    
    func saveToCoreData(_ dto: Currency) {
        CurrencyMapper.toCurrencyEntity(from: dto, context: context)
        do {
            try context.save()
        } catch {
            print("[Save To CoreData]", error)
        }
    }
}
