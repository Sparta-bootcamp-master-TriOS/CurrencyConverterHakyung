//
//  MergeUseCaseIml.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

import Foundation

final class MergeUseCaseImpl: MergeUseCase {
    
    private let currencyUseCase: CurrencyUseCaseImpl
    private let coreDataUseCase: CurrencyCoreDataUseCaseImpl
    
    init(
        currencyUseCase: CurrencyUseCaseImpl,
        coreDataUseCase: CurrencyCoreDataUseCaseImpl
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
            guard let coreItem = coreData?.currencyData[countryCode] else { return }
            let isBookmarked = coreItem.isBookmarked
            let updatedDate = coreItem.updatedDate
            let oldRate = coreItem.oldRate
            let mergedItem = CurrencyItemDom(
                countryName: item.countryName,
                rate: item.rate,
                baseCode: item.baseCode,
                isBookmarked: isBookmarked,
                updatedDate: updatedDate,
                oldRate: oldRate,
                newDate: item.newDate
            )
            mergedData[countryCode] = mergedItem
        }
        return CurrencyDomain(currencyData: mergedData)
    }
    
}
