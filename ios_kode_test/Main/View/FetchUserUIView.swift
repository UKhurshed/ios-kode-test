//
//  FetchUserUIView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import UIKit
import SnapKit

protocol FetchUserUIViewDelegate: AnyObject {
    func openUserProfile(data: ViewData)
    func refreshEmployee()
    func searchUser(searchText: String)
    func cancelTapped()
    func repeatAgain()
}

private typealias TableViewDiff = UITableViewDiffableDataSource<FetchUserSection, ViewData>

private typealias TableViewSnapshot = NSDiffableDataSourceSnapshot<FetchUserSection, ViewData>

private enum FetchUserSection {
    case main
}

enum FetchUserItem: Hashable {
    case loading(UUID)
    case fetched(ViewData)
}

class FetchUserUIView: UIView {
    
    private let searchBar = EmployeeSearchBar()
    private let usersTableView = UITableView()
    private let emptyView = EmptyView()
    private let criticalErrorView = CriticalErrorView()
    private let skeletonView = SkeletonListView()
    private let refreshControl = UIRefreshControl()
    private lazy var tableViewDataSource = TableViewDiff(tableView: usersTableView, cellProvider: createCell)

    private var userData: [ViewData] = []
    private var usersDataCount = 0
    var loaded = false
    
    weak var delegate: FetchUserUIViewDelegate?
    
    var isTextFieldActive = false
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        initSearchBar()
        initTableView()
        initSkeletonView()
        initEmptyView()
        initCriticalErrorView()
        initRefreshControl()
    }
    
    private func initSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarDelegate = self
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func initRefreshControl() {
        refreshControl.tintColor = UIColor(rgb: 0xFF595F67)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        delegate?.refreshEmployee()
        refreshControl.endRefreshing()
    }
    
    private func initTableView() {
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        usersTableView.register(UserTVC.self, forCellReuseIdentifier: UserTVC.identifier)
        usersTableView.separatorStyle = .none
        usersTableView.refreshControl = refreshControl
        usersTableView.delegate = self
        
        addSubview(usersTableView)
        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func initSkeletonView() {
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        skeletonView.isHidden = true
        
        addSubview(skeletonView)
        skeletonView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(16)
        }
    }
    
    private func initEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        
        addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initCriticalErrorView() {
        criticalErrorView.translatesAutoresizingMaskIntoConstraints = false
        criticalErrorView.isHidden = true
        criticalErrorView.delegate = self
        
        addSubview(criticalErrorView)
        criticalErrorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(users: [ViewData]) {
        self.criticalErrorView.isHidden = true
        self.searchBar.isHidden = false
        if users.isEmpty {
            usersTableView.isHidden = true
            emptyView.isHidden = false
        } else {
            usersTableView.isHidden = false
            emptyView.isHidden = true
            self.userData = users
            var snapshot = TableViewSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(users)
            tableViewDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func setupGradientSettings() {
        skeletonView.setupSkeletonsFrame()
    }
    
    func showLoader() {
        self.searchBar.isHidden = false
        self.usersTableView.isHidden = true
        self.criticalErrorView.isHidden = true
        self.skeletonView.isHidden = false
    }
    
    func hideLoader() {
        self.searchBar.isHidden = false
        self.usersTableView.isHidden = false
        self.criticalErrorView.isHidden = true
        self.skeletonView.isHidden = true
    }
    
    func showError() {
        self.usersTableView.isHidden = true
        self.searchBar.isHidden = true
        self.criticalErrorView.isHidden = false
        self.skeletonView.isHidden = true
    }
}

extension FetchUserUIView: EmployeeSearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchUser(searchText: searchText)
    }
    
    func cancelTapped() {
        delegate?.cancelTapped()
    }
}

extension FetchUserUIView: CriticalErrorViewDelegate {
    func repeatAgain() {
        delegate?.repeatAgain()
    }
}

extension FetchUserUIView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openUserProfile(data: self.userData[indexPath.row]) 
    }
}
