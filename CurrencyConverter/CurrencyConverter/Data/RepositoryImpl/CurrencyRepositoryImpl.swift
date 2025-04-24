//
//  CurrencyRepositoryImpl.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import Alamofire
import Foundation

final class CurrencyRepositoryImpl: CurrencyRepository {
    
    private let currencyDataSource: CurrencyDataSource
    
    init(currencyDataSource: CurrencyDataSource) {
        self.currencyDataSource = currencyDataSource
    }
    
    func fetchCurrency(completion: @escaping (Result<Currency, CurrencyError>) -> Void) {
        var urlComponents = URLComponents(string: "https://open.er-api.com/v6/latest/USD")

        guard let url = urlComponents?.url else {
            completion(.failure(CurrencyError.network))
            return
        }
        
        currencyDataSource.fetchData(url: url) { result in
            completion(result)
        }
    }
}
