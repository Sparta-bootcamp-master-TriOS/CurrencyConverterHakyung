//
//  CalculatorViewModel.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit

final class CalculatorViewModel: ViewModelProtocol {
    
    enum Action {
        case calculate(String)
    }
    
    enum State {
        case calculateResult(input: String, result: String)
    }

    var action: ((Action) -> Void)?
    var onStateChanged: ((State) -> Void)?

    private(set) var selectedItem: CalculatorCurrency?
    
    init() {
        self.action = { [weak self] action in
            guard let self else { return }
            switch action {
            case .calculate(let input):
                let result = self.calculateCurrency(input: input)
                self.onStateChanged?(.calculateResult(input: input, result: result))
            }
        }
    }
    
    func configureItem(with selectedItem: CalculatorCurrency) {
        self.selectedItem = selectedItem
    }
    
    func calculateCurrency(input: String) -> String {
        guard let input = Double(input),
              let rate = self.selectedItem?.value.rate else { return "" }
        return String(format: "%.2f", input * rate)
    }
}
