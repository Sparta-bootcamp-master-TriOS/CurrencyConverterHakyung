//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit
import Then
import SnapKit

class CurrencyCell: UITableViewCell {
    
    static let identifier = "CurrencyCell"

    private let countryCodeLable = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private let countryLable = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }

    private let rateLable = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .right
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [
            stackView,
            rateLable,
        ]
            .forEach { contentView.addSubview($0) }
        
        [
            countryCodeLable,
            countryLable,
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        rateLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(120)
        }
    }
    
    func configureItem(key: String, value: CurrencyItemPrsn) {
        self.countryCodeLable.text = key
        self.countryLable.text = value.countryName
        self.rateLable.text = "\(value.rate)"
    }
}

#Preview {
    CurrencyViewController()
}
