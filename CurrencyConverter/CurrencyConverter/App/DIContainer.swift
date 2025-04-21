//
//  DIContainer.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

final class DIContainer {
    
    func currencyViewModel() -> CurrencyViewModel {
        let currencyDataSource = CurrencyDataSource()
        let currencyRepository = CurrencyRepositoryImpl(currencyDataSource: currencyDataSource)
        let currencyUseCase = CurrencyUseCaseImpl(currencyRepository: currencyRepository)
        let viewModel = CurrencyViewModel(currencyUseCase: currencyUseCase)
        return viewModel
    }
    
    func calculatorViewModel() -> CalculatorViewModel {
        return CalculatorViewModel()
    }
}
