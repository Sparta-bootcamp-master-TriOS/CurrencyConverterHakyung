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
        case toggleBookmark(String)
    }
    
    enum State {
        case currencyItems(SortedCurrencyPrsn)
        case errorForAlert(String)
        case searchResult(SortedCurrencyPrsn)
    }

    var action: ((Action) -> Void)?
    var onStateChanged: ((State) -> Void)?
    
    private(set) var currencyItems: SortedCurrencyPrsn?
    
    private let coreDataUseCase: CoreDataUseCaseImpl
    private let mergeUseCase: MergeUseCaseImpl
    
    init(
        coreDataUseCase: CoreDataUseCaseImpl,
        mergeUseCase: MergeUseCaseImpl
    ) {
        self.coreDataUseCase = coreDataUseCase
        self.mergeUseCase = mergeUseCase
        
        self.action = { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchCurrency:
                self.fetchCurrency()
            case .searchCurrency(let query):
                self.searchCurrency(query: query)
            case .toggleBookmark(let countryCode):
                self.toggleBookmark(countryCode: countryCode)
            }
        }
    }
    
    func fetchCurrency() {
        mergeUseCase.fetchData { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    // CurrencyDom -> CurrencyPrsn
                    var currencyItems = CurrencyPrsn()
                    result.currencyData.forEach {
                        currencyItems[$0.key] =  CurrencyItemPrsn(
                            countryName: $0.value.countryName,
                            rate: $0.value.rate,
                            baseCode: $0.value.baseCode,
                            isBookmarked: $0.value.isBookmarked
                        )
                    }
                    
                    let sortedCurrencyItems = getSortedItems(currencyItems)
                    self.currencyItems = sortedCurrencyItems
                    self.onStateChanged?(.currencyItems(sortedCurrencyItems))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onStateChanged?(.errorForAlert(error.localizedDescription))
                }
            }
        }
    }
    
    // 1. 북마크된 -> 2. 통화코드순 -> 3. 북마크 안된 -> 4. 통화코드순
    func getSortedItems(_ items: CurrencyPrsn) -> SortedCurrencyPrsn {
        let bookmarked = items
            .filter { $0.value.isBookmarked }
            .sorted { $0.key < $1.key }
        
        let unBookmarked = items
            .filter { !$0.value.isBookmarked }
            .sorted { $0.key < $1.key }
        
        return bookmarked + unBookmarked
    }
    
    func searchCurrency(query: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self,
                  let currencyItems = self.currencyItems else { return }
            
            if query.isEmpty {
                self.onStateChanged?(.searchResult(currencyItems))
                return
            }
            
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
    
    func toggleBookmark(countryCode: String) {
        do {
            // CoreData에 해당 countryCode가 존재하는지 확인
            if try
                !self.coreDataUseCase.exits(countryCode: countryCode) {
                try self.coreDataUseCase.insert(countryCode: countryCode)
            }
            
            try self.coreDataUseCase.toggleBookmark(countryCode: countryCode)
            
            guard var currencyItems = self.currencyItems else { return }
            
            for (index, item) in currencyItems.enumerated() {
                if item.key == countryCode {
                    var updatedItems = currencyItems[index].value
                    updatedItems.isBookmarked.toggle()
                    currencyItems[index].value = updatedItems
                }
            }
            
            let sortedCurrencyItems = getSortedItems(
                Dictionary(uniqueKeysWithValues: currencyItems)
            )
            self.currencyItems = sortedCurrencyItems
            self.onStateChanged?(.currencyItems(sortedCurrencyItems))
            
        } catch let error as CoreDataErrorPresentation {
            print(error.description)
        } catch {
            print("[Unknowned Error] At Toggle Bookmark : \(error.localizedDescription)")
        }
    }
}
