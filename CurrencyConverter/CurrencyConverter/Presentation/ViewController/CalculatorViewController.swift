//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit
import SnapKit

final class CalculatorViewController: UIViewController {
    
    var selectedItem: CalculatorCurrency
    private let calculatorView = CalculatorView()
    
    init(selectedItem: CalculatorCurrency) {
        self.selectedItem = selectedItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        calculatorView.configureUI(selectedItem)
        self.view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
