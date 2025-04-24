//
//  ResponseData.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import Foundation

struct Currency: Decodable {
    let baseCode: String
    let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case rates
    }
}
