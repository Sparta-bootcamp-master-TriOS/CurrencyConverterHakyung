//
//  MainViewController+UITableViewDelegate.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.currencyItems.isEmpty ? self.tableView.bounds.height : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calculatorVC = CalculatorViewController(selectedItem: self.currencyItems[indexPath.row])
        self.navigationItem.backButtonTitle = "환율 정보"
        self.navigationController?.pushViewController(calculatorVC, animated: true)
    }
}
