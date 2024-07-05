//
//  EmployeeSearchBar.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.07.2024.
//

import UIKit

protocol EmployeeSearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchBarBookmarkButtonClicked(_ searcBar: UISearchBar)
}

final class EmployeeSearchBar: UISearchBar {
    
    weak var searchBarDelegate: EmployeeSearchBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSearchBar() {
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.searchBarStyle = .minimal
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту...",
                                                                                attributes: [NSAttributedString.Key.foregroundColor:
                                                                                            UIColor(rgb: 0xC3C3C6)])
        self.searchTextField.layer.cornerRadius = 16
        self.searchTextField.clipsToBounds = true
        
        self.searchTextField.textColor = UIColor(rgb: 0x050510)
        
        self.setImage(UIImage(named: "search_bar"), for: .search, state: .normal)
        self.setImage(UIImage(named: "unselected_filter"), for: .bookmark, state: .normal)
        self.setImage(UIImage(named: "selected_filter"), for: .bookmark, state: .selected)
        self.showsBookmarkButton = true
        self.setImage(UIImage(named: "clear"), for: .clear, state: .normal)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(rgb: 0x6534FF),
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    }
}

extension EmployeeSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarDelegate?.searchBar(searchBar, textDidChange: searchText)
        self.setImage(UIImage(named: "search_filled"), for: .search, state: .normal)
        self.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
        self.setImage(UIImage(named: "search_filled"), for: .search, state: .normal)
        self.showsBookmarkButton = false
        self.placeholder = ""
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.tintColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.showsCancelButton = false
        setImage(UIImage(named: "search_bar"), for: .search, state: .normal)
        self.showsBookmarkButton = true
        self.placeholder = "Введи имя, тег, почту ..."
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchBarBookmarkButtonClicked(searchBar)
    }
    
}
