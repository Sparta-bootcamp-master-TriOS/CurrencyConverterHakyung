//
//  CurrencyDomain.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

typealias CurrencyDom = CurrencyDomain

struct CurrencyDomain: Decodable {
    let countryCode: String
    let countryName: String
    let rate: Double
}
