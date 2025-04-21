//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit
import SnapKit

final class CalculatorViewController: UIViewController {
        
    let viewModel = DIContainer().calculatorViewModel()
    
    private let calculatorView = CalculatorView()
    
    var selectedItem: CalculatorCurrency
    
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
        amountTextFieldHandler()
    }
    
    private func amountTextFieldHandler() {
        calculatorView.onConvertButtonTapped = { [weak self] input in
            guard let self else { return }
            if (Double(input) != nil) {
                let result = viewModel.calculateCurrency(input: input, rate: selectedItem.value.rate)
                calculatorView.updateResult(input: input, result: result)
            } else {
                let alert = UIAlertController(
                    title: "오류",
                    message: input.isEmpty ? "금액을 입력해주세요" : "올바른 숫자를 입력해주세요",
                    preferredStyle: .alert
                )
                let cancel = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancel)
                view.endEditing(true)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
