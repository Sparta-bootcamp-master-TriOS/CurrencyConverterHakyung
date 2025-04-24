//
//  CurrencyUseCase.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

protocol CurrencyUseCase {
    func loadCurrency(completion: @escaping (Result<[CurrencyDom], CurrencyError>) -> Void)
}
