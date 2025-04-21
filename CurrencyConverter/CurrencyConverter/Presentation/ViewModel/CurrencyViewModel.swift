//
//  MainViewModel.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

final class CurrencyViewModel {
    
    var onItemsUpdate: ((SortedCurrencyPrsn) -> Void)?
    var onError: ((String) -> Void)?
    
    private(set) var currencyItems = SortedCurrencyPrsn()
    
    private let currencyUseCase: CurrencyUseCaseImpl
    
    init(currencyUseCase: CurrencyUseCaseImpl) {
        self.currencyUseCase = currencyUseCase
    }
    
    func loadItems() {
        currencyUseCase.loadCurrency { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    var currencyItems = CurrencyPrsn()
                    result.currencyData.forEach {
                        currencyItems[$0.key] =  CurrencyItemPrsn(countryName: $0.value.countryName, rate: $0.value.rate)
                    }
                    self.currencyItems = getSortedItems(currencyItems)
                    self.onItemsUpdate?(self.currencyItems)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func getSortedItems(_ item: CurrencyPrsn) -> SortedCurrencyPrsn {
        return item.sorted { $0.key < $1.key }
    }
    
    func searchCurrency(query: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let filterdItems: SortedCurrencyPrsn = self.currencyItems
                .filter {
                    $0.key.localizedCaseInsensitiveContains(query) ||
                    $0.value.countryName.localizedCaseInsensitiveContains(query)
                }.sorted {
                    $0.key < $1.key
                }
            self.onItemsUpdate?(filterdItems)
        }
    }
}
