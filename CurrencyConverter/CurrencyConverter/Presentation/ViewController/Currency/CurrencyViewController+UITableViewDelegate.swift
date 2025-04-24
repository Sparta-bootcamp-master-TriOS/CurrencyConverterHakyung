//
//  MainViewController+UITableViewDelegate.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isEmpty = self.currencyItems?.isEmpty ?? true
        return isEmpty ? self.tableView.bounds.height : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = self.currencyItems, !items.isEmpty else { return }
        let selectedItem = items[indexPath.row]
        
        let viewModel = DIContainer().calculatorViewModel()
        viewModel.configureItem(with: selectedItem)
        
        let calculateVC = CalculatorViewController(viewModel: viewModel)
        self.navigationItem.backButtonTitle = "환율 정보"
        self.navigationController?.pushViewController(calculateVC, animated: true)
    }
}
