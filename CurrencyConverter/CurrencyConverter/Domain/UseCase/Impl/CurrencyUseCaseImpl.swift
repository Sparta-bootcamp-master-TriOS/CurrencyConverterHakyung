//
//  CurrencyUseCase.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

final class CurrencyUseCaseImpl: CurrencyUseCase {
    
    private let currencyRepository: CurrencyRepositoryImpl
    
    init(currencyRepository: CurrencyRepositoryImpl) {
        self.currencyRepository = currencyRepository
    }
    
    func loadCurrency(completion: @escaping (Result<Currency, CurrencyError>) -> Void) {
        currencyRepository.fetchCurrency { result in
            completion(result)
        }
    }
}
