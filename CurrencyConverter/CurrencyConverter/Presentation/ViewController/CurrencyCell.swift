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

    private let currencyCodeLable = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let rateLable = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [ currencyCodeLable, rateLable ]
            .forEach { contentView.addSubview($0) }
        
        currencyCodeLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        rateLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureItems(currencyCode: String?, rate: String?) {
        guard let currencyCode, let rate else { return }
        self.currencyCodeLable.text = currencyCode
        self.rateLable.text = rate
    }
}
