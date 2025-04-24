//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

protocol CurrencyRepository {
    func fetchCurrency(completion: @escaping (Result<Currency, CurrencyError>) -> Void)
}
