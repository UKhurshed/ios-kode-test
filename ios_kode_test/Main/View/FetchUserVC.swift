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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func presentAlertError(message: String) {
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

