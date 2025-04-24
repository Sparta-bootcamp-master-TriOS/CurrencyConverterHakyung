//
//  MergeUseCaseIml.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

import Foundation

final class MergeUseCaseImpl: MergeUseCase {
    
    private let currencyUseCase: CurrencyUseCaseImpl
    private let coreDataUseCase: CoreDataUseCaseImpl
    
    init(
        currencyUseCase: CurrencyUseCaseImpl,
        coreDataUseCase: CoreDataUseCaseImpl
    ) {
        self.currencyUseCase = currencyUseCase
        self.coreDataUseCase = coreDataUseCase
    }
    
    func fetchData(completion: @escaping (Result<CurrencyDom, CurrencyError>) -> Void) {
        currencyUseCase.fetchCurrency { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                let mergedResult: Result<CurrencyDomain, CurrencyError> = {
                    do {
                        let coreData = try self.coreDataUseCase.fetchAll()
                        let merged = self.merge(currencyApi: result, coreData: coreData)
                        return .success(merged)
                    } catch {
                        return .failure(error as! CurrencyError)
                    }
                }()
                
                completion(mergedResult)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func merge(currencyApi: CurrencyDomain, coreData: CurrencyDomain?) -> CurrencyDomain {
        var mergedData: [String: CurrencyItemDom] = [:]
        
        currencyApi.currencyData.forEach { countryCode, item in
            let isBookmarked = coreData?.currencyData[countryCode]?.isBookmarked ?? false
            let mergedItem = CurrencyItemDom(
                countryName: item.countryName,
                rate: item.rate,
                baseCode: item.baseCode,
                isBookmarked: isBookmarked
            )
            mergedData[countryCode] = mergedItem
        }
        return CurrencyDomain(currencyData: mergedData)
    }
    
}
