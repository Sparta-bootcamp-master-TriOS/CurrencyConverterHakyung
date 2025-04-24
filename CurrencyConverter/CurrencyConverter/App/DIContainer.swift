//
//  DIContainer.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import CoreData
import UIKit

final class DIContainer {
    
    private let context: NSManagedObjectContext = {
        (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    }()
    
    func currencyViewModel() -> CurrencyViewModel {
        // Currency
        let currencyDataSource = CurrencyDataSource()
        let currencyRepository = CurrencyRepositoryImpl(
            currencyDataSource: currencyDataSource,
            context: context
        )
        let currencyUseCase = CurrencyUseCaseImpl(currencyRepository: currencyRepository)
        
        // CoreDate
        let coreDataSource = CurrencyCoreDataSource(context: context)
        let coreDataRepository = CurrencyCoreDataRepositoryImpl(coreDataSource: coreDataSource)
        let coreDataUseCase = CurrencyCoreDataUseCaseImpl(coreDataRepository: coreDataRepository)
        
        // Merge: Currency + CoreDate
        let mergeUseCase = MergeUseCaseImpl(
            currencyUseCase: currencyUseCase,
            coreDataUseCase: coreDataUseCase
        )
        
        // ViewModel
        let viewModel = CurrencyViewModel(
            coreDataUseCase: coreDataUseCase,
            mergeUseCase: mergeUseCase
        )
        return viewModel
    }
    
    func calculatorViewModel() -> CalculatorViewModel {
        return CalculatorViewModel()
    }
    
}
