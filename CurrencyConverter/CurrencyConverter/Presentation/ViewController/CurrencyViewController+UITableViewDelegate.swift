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
        let viewModel = DIContainer().calculatorViewModel()
        viewModel.configureItem(with: self.currencyItems[indexPath.row])
        
        let viewController = CalculatorViewController(viewModel: viewModel)
        
        self.navigationItem.backButtonTitle = "환율 정보"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
