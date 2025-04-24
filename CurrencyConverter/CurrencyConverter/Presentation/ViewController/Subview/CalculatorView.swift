//
//  CalculatorView.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit
import Then
import SnapKit

final class CalculatorView: UIView {
    
    private let contentView = UIView()
    
    private let titleLable = UILabel().then {
        $0.text = "환율 계산기"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 30, weight: .black)
    }
    
    private let labelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 4
    }
    
    private let countryCodeLable = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 24)
    }
    
    private let countryNameLable = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private let amountTextField = UITextField().then {
        $0.placeholder = "금액을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .decimalPad
        $0.textAlignment = .center
    }
    
    private let convertButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        config.attributedTitle = AttributedString("환율 계산", attributes: AttributeContainer(attributes))

        $0.configuration = config
        $0.layer.cornerRadius = 8
    }
    
    private let resultLabel = UILabel().then {
        $0.text = "계산 결과가 여기에 표시됩니다"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(_ item: CalculatorCurrency) {
        self.countryCodeLable.text = item.key
        self.countryNameLable.text = item.value.countryName
    }
    
    private func configureSubview() {
        self.backgroundColor = .white
        
        addSubview(contentView)
        
        [
            titleLable,
            labelStackView,
            amountTextField,
            convertButton,
            resultLabel
        ]
            .forEach { contentView.addSubview($0) }
        
        [
            countryCodeLable,
            countryNameLable,
        ]
            .forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func configureAutoLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLable.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(20)
        }
        
        labelStackView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLable.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        amountTextField.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(labelStackView.snp.bottom).offset(32)
            $0.height.equalTo(44)
        }
        
        convertButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(amountTextField.snp.bottom).offset(24)
            $0.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(convertButton.snp.bottom).offset(32)
        }
    }
}
