//
//  CurrencyUseCase.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import Foundation

final class CurrencyUseCaseImpl: CurrencyUseCase {
    
    private let currencyRepository: CurrencyRepositoryImpl
    
    init(currencyRepository: CurrencyRepositoryImpl) {
        self.currencyRepository = currencyRepository
    }
    
    func fetchCurrency(completion: @escaping (Result<CurrencyDom, CurrencyError>) -> Void) {
        currencyRepository.fetchCurrency { result in
            switch result {
            case .success(let result):
                let currencyData: [String: CurrencyItemDom] = result.rates.reduce(into: [:]) { dict, element in
                    
                    let (countryCode, rate) = element
                    let countryName = CountryCode.countryCode[countryCode] ?? "nil"
                    let baseCode = result.baseCode
                    
                    dict[countryCode] = CurrencyItemDom(
                        countryName: countryName,
                        rate: rate,
                        baseCode: baseCode,
                        
                        // CoreData
                        isBookmarked: false
                    )
                }
                completion(.success(CurrencyDom(currencyData: currencyData)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
