//
//  LabelStatusSetter.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
extension UILabel {
    public func setStatusForLabel(ofTextField textField: UITextField?, ofTextView textView:UITextView?, validityStatus IsValid:Bool) {
        self.isHidden = false
        if(IsValid) {
            self.text! = RegistrationStatus.VALID_FIELD.rawValue
            self.textColor = Colors.GREEN
            guard let textFieldUnwrapped = textField else {
                textView!.setBottomBorder(withColor: Colors.DARK_BLUE.cgColor)
                return
            }
            textFieldUnwrapped.setBottomBorder(withColor: Colors.DARK_BLUE.cgColor)
        } else {
            self.text! = RegistrationStatus.INVALID_FIELD.rawValue
            self.textColor = Colors.RED
            guard let textFieldUnwrapped = textField else {
                textView!.setBottomBorder(withColor: Colors.RED.cgColor)
                return
            }
            textFieldUnwrapped.setBottomBorder(withColor: Colors.RED.cgColor)
        }
    }
}
