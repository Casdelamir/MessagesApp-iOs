//
//  UIViewExtention.swift
//  MessagesApp-iOS
//
//  Created by Mañanas on 17/9/24.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true;
    }
    
    func roundCorners() {
        self.roundCorners(radius: self.layer.frame.width / 2)
    }
    
    func setBorder(width: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func layerGradient() {
            let layer : CAGradientLayer = CAGradientLayer()
            layer.frame.size = self.frame.size
            layer.frame.origin = CGPointMake(0.0,0.0)
            layer.cornerRadius = CGFloat(frame.width / 20)

        let color0 = UIColor(red:0/255, green:0/255, blue:255.0/255, alpha:0.9).cgColor
        let color1 = UIColor(red:0/255, green:255/255, blue: 255/255, alpha:0.1).cgColor

            layer.colors = [color1,color0]
        self.layer.insertSublayer(layer, at: 0)
        }
}
