//
//  UserTVC.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 05.05.2024.
//

import UIKit
import Kingfisher

class UserTVC: UITableViewCell {

    static let identifier = "UserTVC"
    
    private let backView = UIView()
    private let avatarImgView = UIImageView()
    private let fioLbl = UILabel()
    private let stackView = UIStackView()
    private let professionLbl = UILabel()
    private let departmentLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initBackView()
        initAvatarImgView()
        initStackView()
        initFioLbl()
        initDepartment()
    }
    
    private func initBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    private func initAvatarImgView() {
        avatarImgView.translatesAutoresizingMaskIntoConstraints = false
        avatarImgView.layer.cornerRadius = 72 / 2
        avatarImgView.clipsToBounds = true
        backView.addSubview(avatarImgView)
        
        avatarImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.height.width.equalTo(72)
            make.leading.equalToSuperview()
        }
    }
    
    private func initStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        backView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImgView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func initFioLbl() {
        fioLbl.translatesAutoresizingMaskIntoConstraints = false
        fioLbl.font = .systemFont(ofSize: 16, weight: .medium)
        fioLbl.textColor = .black
        
        stackView.addArrangedSubview(fioLbl)
    }
    
    private func initDepartment() {
        departmentLbl.translatesAutoresizingMaskIntoConstraints = false
        departmentLbl.font = .systemFont(ofSize: 13, weight: .regular)
        departmentLbl.textColor = .gray
        
        stackView.addArrangedSubview(departmentLbl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data: ViewData) {
        avatarImgView.kf.setImage(with: URL(string: data.avatarUrl))
        fioLbl.text = "\(data.firstName) \(data.lastName)"
        departmentLbl.text = data.position
    }
}
