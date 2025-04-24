//
//  CurrencyDomain.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

typealias CurrencyDom = CurrencyDomain
typealias CurrencyItemDom = CurrencyItemDomain

struct CurrencyDomain: Decodable {
    let currencyData: [String: CurrencyItemDom]
}

struct CurrencyItemDomain: Decodable {
    let countryName: String
    let rate: Double
    let baseCode: String
    let isBookmarked: Bool
}
