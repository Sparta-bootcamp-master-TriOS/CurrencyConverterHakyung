//
//  MainViewModel.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

final class CurrencyViewModel {
    
    var onCurrencyUpdate: (([(String, Double)]) -> Void)?
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
                    let sortedRates = result.rates.sorted { $0.key < $1.key }
                    self.onCurrencyUpdate?(sortedRates)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
}
