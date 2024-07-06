//
//  SortingModalUIView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.07.2024.
//

import UIKit

protocol SortingModalUIViewDelegate: AnyObject {
    func backBtnTapped()
}

final class SortingModalUIView: UIView {
    
    private let backBtn = UIButton()
    private let sortLabel = UILabel()
    
    weak var delegate: SortingModalUIViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initBackBtn()
        initSortLabel()
    }
    
    private func initBackBtn() {
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        
        addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(22)
            make.height.width.equalTo(24)
        }
    }
    
    @objc private func backBtnPressed() {
        delegate?.backBtnTapped()
    }
    
    private func initSortLabel() {
        sortLabel.translatesAutoresizingMaskIntoConstraints = false
        sortLabel.text = "Сортировка"
        sortLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        addSubview(sortLabel)
        sortLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
