//
//  CoreDataError.swift
//  CurrencyConverter
//
//  Created by kingj on 4/23/25.
//

enum CoreDataError: Error {
    case fetchFailed
    case saveFailed
    
    var description: String {
        switch self {
        case .fetchFailed:
            return "데이터를 불러오는데 실패했습니다."
        case .saveFailed:
            return "데이터를 저장하는데 실패했습니다."
        }
    }
}
