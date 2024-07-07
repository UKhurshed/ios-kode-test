//
//  SkeletonView.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 07.07.2024.
//

import UIKit

class SkeletonViewItem: UIView {

    private let circleImage = UIView()
    private let label = UILabel()
    private let desc = UILabel()
    private let gradientLayer = CAGradientLayer()
    private let circleLayer = CAGradientLayer()
    private let descLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    private func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.layer.cornerRadius = 72 / 2
        
        desc.translatesAutoresizingMaskIntoConstraints = false
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        label.layer.addSublayer(gradientLayer)
        
        let labelGroup = makeAnimationGroup()
        labelGroup.beginTime = 0.0
        gradientLayer.add(labelGroup, forKey: "backgroundColor")
        
        
        circleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        circleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        circleImage.layer.addSublayer(circleLayer)
        
        let circleGroup = makeAnimationGroup()
        circleGroup.beginTime = 0.0
        circleLayer.add(circleGroup, forKey: "backgroundColor")
        
        descLayer.startPoint = CGPoint(x: 0, y: 0.5)
        descLayer.endPoint = CGPoint(x: 1, y: 0.5)
        desc.layer.addSublayer(descLayer)
        
        let descGroup = makeAnimationGroup()
        descGroup.beginTime = 0.0
        descLayer.add(descGroup, forKey: "backgroundColor")
    }
    
    private func layout() {
        addSubview(circleImage)
        circleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(72)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalTo(circleImage.snp.trailing).offset(16)
            make.height.equalTo(16)
            make.width.equalTo(144)
        }
        
        addSubview(desc)
        desc.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(6)
            make.leading.equalTo(circleImage.snp.trailing).offset(16)
            make.height.equalTo(12)
            make.width.equalTo(80)
        }
    }
    
    private func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = R.color.grey_light()?.cgColor
        anim1.toValue = R.color.grey_dark()?.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFrames() {
        circleLayer.frame = circleImage.bounds
        circleLayer.cornerRadius = circleImage.bounds.height / 2
        
        gradientLayer.frame = label.bounds
        gradientLayer.cornerRadius = label.bounds.height / 2
        
        descLayer.frame = desc.bounds
        descLayer.cornerRadius = desc.bounds.height / 2
    }
}
