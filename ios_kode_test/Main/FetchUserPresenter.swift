//
//  FetchUserPresenter.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import Foundation


protocol FetchUserViewInput: AnyObject {
    func fetch()
    func searchText(searchText: String)
    func clearState()
}

protocol DisplayLogic: AnyObject {
    func showUsers(items: [ViewData])
    func showLoader()
    func hideLoader()
    func showError(message: String)
}

class FetchUserPresenter: FetchUserViewInput {
    
    weak var viewController: DisplayLogic?
    var fetchUser: FetchAllUsers!
    
    func fetch() {
        viewController?.showLoader()
        fetchUser.fetchUsers { [weak self] model, error in
            self?.viewController?.hideLoader()
            if let error {
                self?.viewController?.showError(message: error)
            } else {
                if let model = model {
                    self?.viewController?.showUsers(items: model)
                }
            }
        }
    }
    
    func searchText(searchText: String) {
        let result = fetchUser.searchUsers(searchText: searchText)
        viewController?.showUsers(items: result)
    }
    
    func clearState() {
        let result = fetchUser.clearState()
        viewController?.showUsers(items: result)
    }
}
