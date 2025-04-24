//
//  CurrencyError.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

enum CurrencyError: Error {
    case network
    case decoding
    case unknown
    
    var description: String {
        switch self {
        case .network:
            return "네트워크 오류가 발생했습니다."
        case .decoding:
            return "데이터를 해석하는데 실패했습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
