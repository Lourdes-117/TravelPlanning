//
//  ViewDesign.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//
import UIKit

extension UIView {
    public func setGradientBackground(startColor:UIColor, endColor:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    public func applyViewTheme(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 15.0;
        self.layer.shadowColor = CurrentTheme.SHADOW_COLOR.cgColor;
        self.layer.backgroundColor = CurrentTheme.BACKGROUND_COLOR.cgColor
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    public func removeViewTheme(){
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0;
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
