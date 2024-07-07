//
//  FetchUserVC.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 30.04.2024.
//

import UIKit

class FetchUserVC: UIViewController {
    
    var presenterInput: FetchUserViewInput!
    
    private var fetchUserView: FetchUserUIView {
        self.view as! FetchUserUIView
    }
    
    override func loadView() {
        view = FetchUserUIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUserView.setupGradientSettings()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserView.delegate = self
        presenterInput.fetch()
    }
}

extension FetchUserVC: DisplayLogic {
    func showLoader() {
        DispatchQueue.main.async {
            self.fetchUserView.showLoader()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.fetchUserView.hideLoader()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.fetchUserView.showError()
        }
    }
    
    func showUsers(items: [ViewData]) {
        DispatchQueue.main.async {
            self.fetchUserView.setupData(users: items)
        }
    }
}

extension FetchUserVC: FetchUserUIViewDelegate {
    
    func openUserProfile(data: ViewData) {
        let vc = UserProfileVC(data: data)
        vc.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshEmployee() {
        presenterInput.fetch()
    }
    
    func searchUser(searchText: String) {
        presenterInput.searchText(searchText: searchText)
    }

    func cancelTapped() {
        presenterInput.clearState()
    }
    
    func repeatAgain() {
        presenterInput.fetch()
    }
}

