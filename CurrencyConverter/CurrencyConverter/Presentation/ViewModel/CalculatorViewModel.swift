//
//  CalculatorViewModel.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit

final class CalculatorViewModel {
    
    func calculateCurrency(input: String, rate: Double) -> String {
        guard let input = Double(input) else { return "invalid" }
        return String(format: "%.3f", input * rate)
    }
}
