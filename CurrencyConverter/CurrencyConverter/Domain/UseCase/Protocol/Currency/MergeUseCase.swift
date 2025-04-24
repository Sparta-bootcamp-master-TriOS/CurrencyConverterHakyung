//
//  MergeUseCase.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

protocol MergeUseCase {
    func fetchData(completion: @escaping (Result<CurrencyDomain, CurrencyError>) -> Void)
}
