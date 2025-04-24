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
    
    func fetchMockData(url: URL, completion: @escaping (Result<Currency, CurrencyError>) -> Void) {
        // fetch MockCurrencyResponse
        guard let url = Bundle.main.url(forResource: "MockCurrencyResponse", withExtension: "json") else {
            print("File Not Found")
            completion(.failure(.unknown))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let currencyResult = try JSONDecoder().decode(Currency.self, from: data)
            completion(.success(currencyResult))
        } catch {
            print("File Decoding Error")
            completion(.failure(.unknown))
            return
        }
    }
}
