//
//  UIView + Extension.swift
//  ios_kode_test
//
//  Created by Khurshed Umarov on 28.05.2024.
//

import UIKit

extension UIView {
    //Gesture
    func addTapGesture(action : @escaping () -> Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
    
    class MyTapGestureRecognizer: UITapGestureRecognizer {
        var action : (() -> Void)? = nil
    }
}
