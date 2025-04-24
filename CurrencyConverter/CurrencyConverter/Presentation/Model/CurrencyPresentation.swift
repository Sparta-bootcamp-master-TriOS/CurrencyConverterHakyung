//
//  CurrencyPresentation.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

typealias CurrencyPrsn = [String: CurrencyItemPrsn]

typealias SortedCurrencyPrsn = [(key: String, value: CurrencyItemPrsn)]

typealias CurrencyItemPrsn = CurrencyItemPresentation

struct CurrencyItemPresentation: Decodable {
    let countryName: String
    let rate: Double
    let baseCode: String
    var isBookmarked: Bool
}
