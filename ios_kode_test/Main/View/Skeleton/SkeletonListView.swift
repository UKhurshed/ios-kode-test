//
//  SkeletonListView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 07.07.2024.
//

import UIKit

class SkeletonListView: UIView {
    
    private let firstSkeletonView = SkeletonViewItem()
    private let secondSkeletonView = SkeletonViewItem()
    private let thirdSkeletonView = SkeletonViewItem()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSkeletonsView()
    }
    
    private func initSkeletonsView() {
        firstSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        secondSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        thirdSkeletonView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(firstSkeletonView)
        firstSkeletonView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(84)
        }
        
        addSubview(secondSkeletonView)
        secondSkeletonView.snp.makeConstraints { make in
            make.top.equalTo(firstSkeletonView.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(84)
        }
        
        addSubview(thirdSkeletonView)
        thirdSkeletonView.snp.makeConstraints { make in
            make.top.equalTo(secondSkeletonView.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(84)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSkeletonsFrame() {
        firstSkeletonView.setupFrames()
        secondSkeletonView.setupFrames()
        thirdSkeletonView.setupFrames()
    }
}
