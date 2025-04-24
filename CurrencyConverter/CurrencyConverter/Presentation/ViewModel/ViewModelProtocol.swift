//
//  ViewModelProtocol.swift
//  CurrencyConverter
//
//  Created by kingj on 4/22/25.
//

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State
    
    var action: ((Action) -> Void)? { get }
    var onStateChanged: ((State) -> Void)? { get }
}
