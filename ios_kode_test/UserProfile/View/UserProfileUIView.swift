//
//  UserProfileUIView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 28.05.2024.
//

import UIKit
import Kingfisher

protocol UserProfileUIViewDelegate: AnyObject {
    func backPressed()
    func phoneTelTapped(phone: String)
}

class UserProfileUIView: UIView {
    
    private let backBtn = CustomBackBtnView()
    private let avatarImgView = UIImageView()
    private let fioLbl = UILabel()
    private let departmentLbl = UILabel()
    private let positionLbl = UILabel()
    private let infoBackView = UIView()
    private let birthInfoCard = UserInfoSection()
    private let separatorLineV = UIView()
    private let phoneNumberCard = UserInfoSection()
    
    weak var delegate: UserProfileUIViewDelegate?
    
    var viewData: ViewData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(rgb: 0xF7F7F8)
        
        initBackBtn()
        initAvatarImgView()
        initFioLbl()
        initDepartmentLbl()
        initPositionLbl()
        initInfoBackView()
        initBirthInfoCard()
        initSeparatorLineV()
        initPhoneNumCard()
    }
    
    private func initBackBtn() {
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.setImage(R.image.arrow_left(), for: .normal)
        backBtn.isUserInteractionEnabled = true
        backBtn.isHidden = false
        backBtn.layer.opacity = 1.0
        
        addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
        }
        
        backBtn.addTarget(self, action: #selector(initBack), for: .touchUpInside)
    }
    
    @objc private func initBack() {
        delegate?.backPressed()
    }
    
    private func initAvatarImgView() {
        avatarImgView.translatesAutoresizingMaskIntoConstraints = false
        avatarImgView.layer.cornerRadius = 104 / 2
        avatarImgView.clipsToBounds = true
        
        addSubview(avatarImgView)
        avatarImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(72)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(104)
        }
    }
    
    private func initFioLbl() {
        fioLbl.translatesAutoresizingMaskIntoConstraints = false
        fioLbl.font = .systemFont(ofSize: 24, weight: .bold)
        fioLbl.textColor = .black
        
        addSubview(fioLbl)
        fioLbl.snp.makeConstraints { make in
            make.top.equalTo(avatarImgView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initDepartmentLbl() {
        departmentLbl.translatesAutoresizingMaskIntoConstraints = false
        departmentLbl.font = .systemFont(ofSize: 17, weight: .regular)
        departmentLbl.textColor = UIColor(rgb: 0x97979B)
        
        addSubview(departmentLbl)
        departmentLbl.snp.makeConstraints { make in
            make.top.equalTo(avatarImgView.snp.bottom).offset(28)
            make.leading.equalTo(fioLbl.snp.trailing).offset(4)
        }
    }
    
    private func initPositionLbl() {
        positionLbl.translatesAutoresizingMaskIntoConstraints = false
        positionLbl.font = .systemFont(ofSize: 13, weight: .regular)
        positionLbl.textColor = R.color.text_black_light()
        
        addSubview(positionLbl)
        positionLbl.snp.makeConstraints { make in
            make.top.equalTo(fioLbl.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initInfoBackView() {
        infoBackView.translatesAutoresizingMaskIntoConstraints = false
        infoBackView.backgroundColor = .white
        
        addSubview(infoBackView)
        infoBackView.snp.makeConstraints { make in
            make.top.equalTo(positionLbl.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func initBirthInfoCard() {
        birthInfoCard.translatesAutoresizingMaskIntoConstraints = false
        
        infoBackView.addSubview(birthInfoCard)
        birthInfoCard.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func initSeparatorLineV() {
        separatorLineV.translatesAutoresizingMaskIntoConstraints = false
        separatorLineV.backgroundColor = R.color.grey_light()
        
        infoBackView.addSubview(separatorLineV)
        separatorLineV.snp.makeConstraints { make in
            make.top.equalTo(birthInfoCard.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
    }
    
    private func initPhoneNumCard() {
        phoneNumberCard.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberCard.addTapGesture { [weak self] in
            guard let self, let phone = viewData?.phone else { return }
            self.delegate?.phoneTelTapped(phone: phone)
        }
        
        infoBackView.addSubview(phoneNumberCard)
        phoneNumberCard.snp.makeConstraints { make in
            make.top.equalTo(separatorLineV.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(data: ViewData) {
        self.viewData = data
        avatarImgView.kf.setImage(with: URL(string: data.avatarUrl))
        fioLbl.text = "\(data.firstName) \(data.lastName)"
        departmentLbl.text = data.userTag
        positionLbl.text = data.position
        birthInfoCard.setupData(icon: R.image.star(), title: data.birthday, desc: data.birthday)
        phoneNumberCard.setupData(icon: R.image.telephone(), title: data.phone, desc: nil)
    }
}

class CustomBackBtnView: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -20, dy: -20).contains(point)
    }
}
