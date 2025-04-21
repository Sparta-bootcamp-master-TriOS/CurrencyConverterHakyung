//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by kingj on 4/19/25.
//

import UIKit
import Then
import SnapKit

final class CurrencyViewController: UIViewController {
    
    private let currencyViewModel = DIContainer.shared.currencyViewModel()
    private(set) var currencyItems: [CurrencyPrsn]?
    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
    }
    
    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.placeholder = "통화 검색"
        $0.searchBarStyle = .minimal
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureAutoLayout()
        currencyViewModel.loadCurrency()
        updateCurrency()
        showErrorAlert()
    }
    
    private func updateCurrency() {
        currencyViewModel.onCurrencyUpdate = { [weak self] result in
            guard let self else { return }
            self.currencyItems = result
            self.tableView.reloadData()
        }
    }
    
    private func showErrorAlert() {
        currencyViewModel.onError = { [weak self] error in
            let alert = UIAlertController(title: "오류", message: "데이터를 불러올 수 없습니다", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .default)
            alert.addAction(cancel)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func configureSubview() {
        view.backgroundColor = .white
        
        [
            tableView,
            searchBar
        ]
            .forEach { view.addSubview($0) }
    }
    
    private func configureAutoLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}
