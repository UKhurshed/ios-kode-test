//
//  EmployeeSearchBar.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.07.2024.
//

import UIKit

protocol EmployeeSearchBarDelegate: AnyObject {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func cancelTapped()
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
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: R.string.strings.enterNameTag(),
                                                                                attributes: [NSAttributedString.Key.foregroundColor:
                                                                                            UIColor(rgb: 0xC3C3C6)])
        self.searchTextField.layer.cornerRadius = 16
        self.searchTextField.clipsToBounds = true
        
        self.searchTextField.textColor = UIColor(rgb: 0x050510)
        
        self.setImage(R.image.search_bar(), for: .search, state: .normal)
        self.showsBookmarkButton = false
        self.setImage(R.image.clear_text(), for: .clear, state: .normal)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = R.string.strings.cancel()
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(rgb: 0x6534FF),
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    }
}

extension EmployeeSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarDelegate?.searchBar(searchBar, textDidChange: searchText)
        self.setImage(R.image.search_filled(), for: .search, state: .normal)
        self.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
        self.setImage(R.image.search_filled(), for: .search, state: .normal)
        self.placeholder = ""
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.tintColor = UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchTextField.resignFirstResponder()
        self.searchTextField.text = ""
        setImage(R.image.search_bar(), for: .search, state: .normal)
        self.placeholder = R.string.strings.enterNameTag()
        self.showsCancelButton = false
        searchBarDelegate?.cancelTapped()
    }
}
