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
    
    private let textField = UITextField()
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
        
        initTextField()
        initTableView()
        initIndicator()
    }
    
    private func initTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите имя, тег, почту..."
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(rgb: 0xF7F7F8).cgColor
        textField.backgroundColor = UIColor(rgb: 0xF7F7F8)
        textField.textColor = UIColor(rgb: 0xC3C3C6)
        textField.layer.cornerRadius = 16
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 40))
        
        let image = UIImage(named: "search_bar")
        
        let imageView = UIImageView(frame: CGRect(x: 12, y: 8, width: 24, height: 24))
        imageView.image = image
        
        leftView.addSubview(imageView)
        
        textField.leftView = leftView
        
        textField.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 40))
        
        let rightImage = UIImage(named: "filter")
        
        let rightImageView = UIImageView(frame: CGRect(x: -12, y: 8, width: 24, height: 24))
        rightImageView.image = rightImage
        
        rightView.addSubview(rightImageView)
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func initTableView() {
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        usersTableView.register(UserTVC.self, forCellReuseIdentifier: UserTVC.identifier)
        usersTableView.separatorStyle = .none
        
        addSubview(usersTableView)
        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
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
