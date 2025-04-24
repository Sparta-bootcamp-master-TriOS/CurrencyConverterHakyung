//
//  MainViewController+UITableViewDataSource.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

extension CurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.currencyItems else { return 1}
        return items.isEmpty ? 1 : items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let items = self.currencyItems else {
            return UITableViewCell()
        }
        
        if items.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.identifier, for: indexPath) as? EmptyCell else {
                return UITableViewCell()
            }
            cell.configureUI()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.selectionStyle = .none
        
        cell.onBookmarkBtnTapped = { [weak self] countryCode in
            guard let self else { return }
            self.viewModel.toggleBookmark(countryCode: countryCode)
        }
        cell.configureUI()
        cell.configureItem(key: item.key, value: item.value)
        return cell
    }
}
