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
        let currencyRepository = CurrencyRepositoryImpl(currencyDataSource: currencyDataSource)
        let currencyUseCase = CurrencyUseCaseImpl(currencyRepository: currencyRepository)
        
        // CoreDate
        let coreDataSource = CoreDataSource(context: context)
        let coreDataRepository = CoreDataRepositoryImpl(coreDataSource: coreDataSource)
        let coreDataUseCase = CoreDataUseCaseImpl(coreDataRepository: coreDataRepository)
        
        let mergeUseCase = MergeUseCaseImpl(
            currencyUseCase: currencyUseCase,
            coreDataUseCase: coreDataUseCase
        )
        
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
