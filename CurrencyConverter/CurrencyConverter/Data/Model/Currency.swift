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
    let timeLastUpdateUnix: Double
    
    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case rates
        case timeLastUpdateUnix = "time_last_update_unix"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseCode = try container.decode(String.self, forKey: .baseCode)
        self.rates = try container.decode([String: Double].self, forKey: .rates)
        self.timeLastUpdateUnix = try container.decode(Double.self, forKey: .timeLastUpdateUnix)
    }
}
