//
//  SortingModalVC.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.07.2024.
//

import UIKit

final class SortingModalVC: UIViewController {
    
    private var sortingModalUIView: SortingModalUIView {
        self.view as! SortingModalUIView
    }
    
    override func loadView() {
        view = SortingModalUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortingModalUIView.delegate = self
    }
}

extension SortingModalVC: SortingModalUIViewDelegate {
    func backBtnTapped() {
        dismiss(animated: true)
    }
}
