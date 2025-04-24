//
//  FetchCurrency.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import Alamofire
import Foundation

final class CurrencyDataSource {
    func fetchData(url: URL, completion: @escaping (Result<Currency, CurrencyError>) -> Void) {
        // fetch Open API
        AF.request(url).responseDecodable(of: Currency.self) { response in
            switch response.result {
            case .success(let currency):
                completion(.success(currency))
                
            case .failure(let error):
                let afError: CurrencyError
                switch error {
                case .sessionTaskFailed:
                    afError = .network
                case .responseSerializationFailed:
                    afError = .decoding
                default:
                    afError = .unknown
                }
                
                completion(.failure(afError))
            }
        }
    }
}
