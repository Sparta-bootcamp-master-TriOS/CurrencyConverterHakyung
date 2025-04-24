//
//  CurrencyUseCase.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

protocol CurrencyUseCase {
    func fetchCurrency(completion: @escaping (Result<CurrencyDom, CurrencyError>) -> Void)
}
