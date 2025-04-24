//
//  MainViewController+UITableViewDataSource.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

extension CurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyItems.isEmpty ? 1 : self.currencyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.currencyItems.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.identifier, for: indexPath) as? EmptyCell else {
                return UITableViewCell()
            }
            cell.configureUI()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        cell.configureUI()
        let key = self.currencyItems[indexPath.row].key
        let value = self.currencyItems[indexPath.row].value
        cell.configureItem(key: key, value: value)
        return cell
    }
}
