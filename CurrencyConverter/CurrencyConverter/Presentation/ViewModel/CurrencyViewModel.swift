//
//  MainViewModel.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

final class CurrencyViewModel {
    
    var onCurrencyUpdate: (([CurrencyPrsn]) -> Void)?
    var onError: ((String) -> Void)?
    
    private let currencyUseCase: CurrencyUseCaseImpl
    
    init(currencyUseCase: CurrencyUseCaseImpl) {
        self.currencyUseCase = currencyUseCase
    }
    
    func loadCurrency() {
        currencyUseCase.loadCurrency { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    let mappedResult: [CurrencyPrsn] = result.compactMap {
                        return CurrencyPrsn(
                            countryCode: $0.countryCode,
                            countryName: $0.countryName,
                            rate: $0.rate
                        )
                    }
                    self.onCurrencyUpdate?(mappedResult)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
}
