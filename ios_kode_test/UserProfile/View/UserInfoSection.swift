//
//  UserInfoSection.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 07.07.2024.
//

import Foundation
import UIKit

class UserInfoSection: UIView {
    
    private let backView = UIView()
    private let iconImg = UIImageView()
    private let titleLbl = UILabel()
    private let descLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initBackView()
        initIconImg()
        initTitleLbl()
        initDescLbl()
    }
    
    private func initBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    private func initIconImg() {
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(iconImg)
        iconImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
    
    private func initTitleLbl() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = .systemFont(ofSize: 16, weight: .medium)
        titleLbl.textColor = .black
        
        backView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImg.snp.trailing).offset(12)
        }
    }
    
    private func initDescLbl() {
        descLbl.translatesAutoresizingMaskIntoConstraints = false
        descLbl.font = .systemFont(ofSize: 16, weight: .medium)
        descLbl.textColor = UIColor(rgb: 0x97979B)
        
        backView.addSubview(descLbl)
        descLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(icon: UIImage?, title: String, desc: String?) {
        iconImg.image = icon
        
        let age = desc?.calculateToAge()
        if let _ = desc, let age, age != -1 {
            descLbl.text = "\(age) года"
            titleLbl.text = title.calculateBirthday()
        } else {
            titleLbl.text = title.formattedPhone()
        }
    }
}
