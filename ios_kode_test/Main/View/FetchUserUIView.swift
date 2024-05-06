//
//  FetchUserUIView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import UIKit
import SnapKit

private typealias TableViewDiff = UITableViewDiffableDataSource<FetchUserSection, ViewData>

private typealias TableViewSnapshot = NSDiffableDataSourceSnapshot<FetchUserSection, ViewData>

private enum FetchUserSection {
    case main
}

class FetchUserUIView: UIView {
    
    private let usersTableView = UITableView()
    private lazy var tableViewDataSource = TableViewDiff(tableView: usersTableView, cellProvider: createCell)
    
    private func createCell(
        tableView: UITableView,
        indexPath: IndexPath,
        data: ViewData
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTVC.identifier, for: indexPath) as! UserTVC
        cell.selectionStyle = .none
        cell.setupData(data: data)
        return cell
    }
    
    private let indicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        initTableView()
        initIndicator()
    }
    
    private func initTableView() {
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        usersTableView.register(UserTVC.self, forCellReuseIdentifier: UserTVC.identifier)
        usersTableView.separatorStyle = .none
        
        addSubview(usersTableView)
        usersTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func initIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.stopAnimating()
        indicator.center = center
        
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(users: [ViewData]) {
        var snapshot = TableViewSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        tableViewDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func showLoader() {
        self.indicator.startAnimating()
        self.usersTableView.isHidden = true
    }
    
    func hideLoader() {
        self.indicator.stopAnimating()
        self.usersTableView.isHidden = false
    }
    
    func showError() {
        self.indicator.stopAnimating()
        self.usersTableView.isHidden = true
    }
}
