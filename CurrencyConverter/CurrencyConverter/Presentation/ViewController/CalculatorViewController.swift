//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit
import SnapKit

final class CalculatorViewController: UIViewController {
            
    private let calculatorView = CalculatorView()
    
    private let viewModel: CalculatorViewModel?
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        calculatorView.configureUI(viewModel?.selectedItem)
        self.view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertBtnAction()
        showCalculatedResult()
    }
    
    private func convertBtnAction() {
        calculatorView.onConvertButtonTapped = { [weak self] input in
            guard let self else { return }
            if (Double(input) != nil) {
                viewModel?.action?(.calculate(input))
            } else {
                showErrorAlert(input)
            }
        }
    }
    
    private func showErrorAlert(_ input: String) {
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
    
    private func showCalculatedResult() {
        viewModel?.onStateChanged = { [weak self] state in
            guard let self else { return }
            switch state {
            case .calculateResult(let input, let result):
                self.calculatorView.updateResult(input: input, result: result)
            }
        }
        
    }
}
