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
    
    func loadCurrency(completion: @escaping (Result<[CurrencyDom], CurrencyError>) -> Void) {
        currencyRepository.fetchCurrency { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let result):
                let sortedRates = result.rates.sorted { $0.key < $1.key }
                let mappedResult: [CurrencyDom] = sortedRates.compactMap { (key, value) in
                    let countryCode = key
                    let countryName = CountryCode.countryCode[key] ?? "nil"
                    let rate = value
                    return CurrencyDom(countryCode: countryCode, countryName: countryName, rate: rate)
                }
                completion(.success(mappedResult))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
