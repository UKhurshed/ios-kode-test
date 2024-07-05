//
//  UserProfileVC.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 27.05.2024.
//

import UIKit

class UserProfileVC: UIViewController {
    
    private let data: ViewData
    
    init(data: ViewData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var userProfile: UserProfileUIView {
        self.view as! UserProfileUIView
    }
    
    override func loadView() {
        view = UserProfileUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userProfile.delegate = self
        userProfile.setupData(data: data)
    }

}

extension UserProfileVC: UserProfileUIViewDelegate {
    func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func phoneTelTapped(phone: String) {
        let tel = "tel://+"
        
        let phoneResult = tel + phone.formattedPhoneToTel()
        guard let url = URL(string: phoneResult) else { return }
    
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
}
