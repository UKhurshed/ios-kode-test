//
//  CriticalErrorView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 06.07.2024.
//

import UIKit

protocol CriticalErrorViewDelegate: AnyObject {
    func repeatAgain()
}

class CriticalErrorView: UIView {
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLbl = UILabel()
    private let descriptionLbl = UILabel()
    private let repeatAgainBtn = UIButton()
    
    weak var delegate: CriticalErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initStackView()
        initImageView()
        initTitleLbl()
        initDescLbl()
        initRepeatAgainBtn()
    }
    
    private func initStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(8, after: imageView)
        stackView.addArrangedSubview(titleLbl)
        stackView.setCustomSpacing(12, after: titleLbl)
        stackView.addArrangedSubview(descriptionLbl)
        stackView.setCustomSpacing(12, after: descriptionLbl)
        stackView.addArrangedSubview(repeatAgainBtn)
    }
    
    private func initImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fly_plane")
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(56)
        }
    }
    
    private func initTitleLbl() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.text = "Какой-то сверхразум все сломал"
        titleLbl.font = .systemFont(ofSize: 17, weight: .bold)
        titleLbl.textColor = UIColor(rgb: 0x050510)
    }
    
    private func initDescLbl() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.text = "Постараемся быстро починить"
        titleLbl.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionLbl.textColor = UIColor(rgb: 0x97979B)
    }
    
    private func initRepeatAgainBtn() {
        repeatAgainBtn.translatesAutoresizingMaskIntoConstraints = false
        repeatAgainBtn.setTitle("Попробовать снова", for: .normal)
        repeatAgainBtn.backgroundColor = .white
        repeatAgainBtn.setTitleColor(UIColor(rgb: 0x6534FF), for: .normal)
        
        repeatAgainBtn.addTarget(self, action: #selector(repeatBtnAction), for: .touchUpInside)
    }
    
    @objc private func repeatBtnAction() {
        delegate?.repeatAgain()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
