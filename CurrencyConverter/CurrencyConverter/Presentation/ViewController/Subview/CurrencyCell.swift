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
    
    var onBookmarkBtnTapped: ((String) -> Void)?

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
    
    private lazy var bookMarkButton = UIButton().then {
        var config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let image = UIImage(systemName: "star", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: config)
        $0.setImage(selectedImage, for: .selected)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.toggleBookMarkBtn()
        }
        
        $0.addAction(action, for: .touchUpInside)
        $0.tintColor = .systemYellow
    }
    
    private let upDownLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.text = "🔼"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func toggleBookMarkBtn() {
        self.bookMarkButton.isSelected.toggle()
        
        guard let countryCode = self.countryCodeLable.text else { return }
        self.onBookmarkBtnTapped?(countryCode)
    }
    
    func configureUI() {
        [
            stackView,
            rateLable,
            upDownLabel,
            bookMarkButton
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
            $0.trailing.equalTo(upDownLabel.snp.leading).offset(-10)
            $0.width.equalTo(120)
        }
        
        upDownLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.trailing.equalTo(bookMarkButton.snp.leading).offset(-15)
        }

        bookMarkButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    func configureItem(key: String, value: CurrencyItemPrsn, icon: String) {
        self.countryCodeLable.text = key
        self.countryLable.text = value.countryName
        self.rateLable.text = String(format: "%.4f", value.rate)
        self.bookMarkButton.isSelected = value.isBookmarked
        self.upDownLabel.text = icon
    }
 }
