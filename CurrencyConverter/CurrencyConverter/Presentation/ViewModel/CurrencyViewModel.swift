//
//  MainViewModel.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

final class CurrencyViewModel: ViewModelProtocol {
    
    enum Action {
        case fetchCurrency
        case searchCurrency(String)
    }
    
    enum State {
        case currencyItems(SortedCurrencyPrsn)
        case errorForAlert(String)
        case searchResult(SortedCurrencyPrsn)
    }

    var action: ((Action) -> Void)?
    var onStateChanged: ((State) -> Void)?
    
    private(set) var currencyItems: SortedCurrencyPrsn?
    
    private let currencyUseCase: CurrencyUseCaseImpl
    
    init(currencyUseCase: CurrencyUseCaseImpl) {
        self.currencyUseCase = currencyUseCase
        
        self.action = { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchCurrency:
                self.fetchCurrency()
            case .searchCurrency(let query):
                self.searchCurrency(query: query)
            }
        }
    }
    
    func fetchCurrency() {
        currencyUseCase.fetchCurrency { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    var currencyItems = CurrencyPrsn()
                    result.currencyData.forEach {
                        currencyItems[$0.key] =  CurrencyItemPrsn(
                            countryName: $0.value.countryName,
                            rate: $0.value.rate,
                            baseCode: $0.value.baseCode
                        )
                    }
                    let sortedCurrencyItems = getSortedItems(currencyItems)
                    self.onStateChanged?(.currencyItems(sortedCurrencyItems))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onStateChanged?(.errorForAlert(error.localizedDescription))
                }
            }
        }
    }
    
    func getSortedItems(_ item: CurrencyPrsn) -> SortedCurrencyPrsn {
        return item.sorted { $0.key < $1.key }
    }
    
    func searchCurrency(query: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self,
                  let currencyItems = self.currencyItems else { return }
            
            let filterdItems: SortedCurrencyPrsn = currencyItems
                .filter {
                    $0.key.localizedCaseInsensitiveContains(query) ||
                    $0.value.countryName.localizedCaseInsensitiveContains(query)
                }.sorted {
                    $0.key < $1.key
                }
            
            self.onStateChanged?(.searchResult(filterdItems))
        }
    }
}
