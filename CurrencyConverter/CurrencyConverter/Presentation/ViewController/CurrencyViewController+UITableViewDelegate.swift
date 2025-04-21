//
//  MainViewController+UITableViewDelegate.swift
//  CurrencyConverter
//
//  Created by kingj on 4/20/25.
//

import UIKit

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
