//
//  CurrencyPresentation.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

typealias CurrencyPrsn = CurrencyPresentation

struct CurrencyPresentation: Decodable {
    let countryCode: String
    let countryName: String
    let rate: Double
}
