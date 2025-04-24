//
//  EmptyCell.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit
import Then
import SnapKit

final class EmptyCell: UITableViewCell {
    
    static let identifier = "EmptyCell"

    private let lable = UILabel().then {
        $0.text = "검색 결과 없음"
        $0.textColor = .secondaryText
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.contentView.backgroundColor = .background
        
        contentView.addSubview(lable)
        
        lable.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
