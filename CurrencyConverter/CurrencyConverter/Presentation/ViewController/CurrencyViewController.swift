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
    
    let viewModel: CurrencyViewModel
    
    var currencyItems: SortedCurrencyPrsn?
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        $0.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.identifier)
    }
    
    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.placeholder = "통화 검색"
        $0.searchBarStyle = .minimal
    }
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureAutoLayout()
        
        onStateChanged()
        viewModel.action?(.fetchCurrency)
    }
    
    private func onStateChanged() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self else { return }
            switch state {
            case .currencyItems(let currencyItems):
                self.updateItems(currencyItems)
            case .errorForAlert(_):
                self.showErrorAlert()
            case .searchResult(let currencyItems):
                self.updateItems(currencyItems)
            }
        }
    }
    
    private func updateItems(_ items: SortedCurrencyPrsn) {
        self.currencyItems = items
        self.tableView.reloadData()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "오류", message: "데이터를 불러올 수 없습니다", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .default)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
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
