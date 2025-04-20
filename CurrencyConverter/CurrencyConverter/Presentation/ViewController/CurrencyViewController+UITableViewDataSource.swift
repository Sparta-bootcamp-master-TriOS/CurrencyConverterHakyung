//
//  MainViewController+UITableViewDataSource.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

extension CurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        cell.configureUI()
        
        let currencyCode = self.currencyItems?[indexPath.row].0
        let rate = String(format: "%.4f", self.currencyItems?[indexPath.row].1 ?? 0)
        cell.configureItems(currencyCode: currencyCode, rate: rate)
        return cell
    }
}
