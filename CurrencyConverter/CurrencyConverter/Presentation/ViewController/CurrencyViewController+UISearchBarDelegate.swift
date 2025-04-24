//
//  CurrencyViewController+UISearchControllerDelegate.swift
//  CurrencyConverter
//
//  Created by kingj on 4/21/25.
//

import UIKit

extension CurrencyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            
        } else {
            guard let text = searchBar.text else { return }
            viewModel.searchCurrency(query: text)
        }
    }
}
