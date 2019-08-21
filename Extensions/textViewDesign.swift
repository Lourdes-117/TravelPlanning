//
//  textViewDesign.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

extension UITextView {
    public func setBottomBorder(withColor borderColorToSet: CGColor) {
        self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.masksToBounds = false
        self.layer.shadowColor = borderColorToSet
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true

        self.backgroundColor = CurrentTheme.TEXTFIELD_BACKGROUND
    }

    public func applyTextViewTheme(){
        self.setBottomBorder(withColor: Colors.DARK_BLUE.cgColor)
    }
}
