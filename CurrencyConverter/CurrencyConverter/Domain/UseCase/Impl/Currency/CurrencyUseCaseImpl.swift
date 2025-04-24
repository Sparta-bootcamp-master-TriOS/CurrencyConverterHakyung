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
                
                self.currencyRepository.saveToCoreData(result)
                
                let currencyData: [String: CurrencyItemDom] = result.rates.reduce(into: [:]) { dict, item in
                    
                    let (countryCode, rate) = item
                    let countryName = CountryCode.countryCode[countryCode] ?? "nil"
                    let baseCode = result.baseCode
                    let newDate = Date(timeIntervalSince1970: result.timeLastUpdateUnix)
                    
                    dict[countryCode] = CurrencyItemDom(
                        countryName: countryName,
                        rate: rate,
                        baseCode: baseCode,
                        
                        // CoreData
                        isBookmarked: false,
                        updatedDate: Date(),
                        oldRate: -1.0,
                        
                        newDate: newDate
                    )
                }
                completion(.success(CurrencyDom(currencyData: currencyData)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
