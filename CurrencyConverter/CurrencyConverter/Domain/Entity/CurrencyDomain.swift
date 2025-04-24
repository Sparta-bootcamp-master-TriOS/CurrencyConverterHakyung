//
//  CurrencyDomain.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

typealias CurrencyDom = CurrencyDomain

struct CurrencyDomain: Decodable {
    let currencyData: [String: CurrencyItem]
}

struct CurrencyItem: Decodable {
    let countryName: String
    let rate: Double
    let baseCode: String
}
