//
//  EmptyView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 06.07.2024.
//

import UIKit

class EmptyView: UIView {
    
    private let imageView = UIImageView()
    private let titleLbl = UILabel()
    private let descriptionLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initImageView()
        initTitleLbl()
        initDescLbl()
    }
    
    private func initImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.empty_list_by_search()
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(56)
        }
    }
    
    private func initTitleLbl() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.text = R.string.strings.weNobodyFound()
        titleLbl.textColor = R.color.text_black_dark()
        
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initDescLbl() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.text = R.string.strings.tryCorrectQuery()
        descriptionLbl.textColor = R.color.text_black_light()
        
        addSubview(descriptionLbl)
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
