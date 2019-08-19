//
//  TextFieldDelegate.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
extension NewTravelDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fromLocation:
            if(!checkFromLocaion()) {
                return false
            }
            toLocation.becomeFirstResponder()
        case toLocation:
            if(!checkToLocaion()) {
                return false
            }
            modeOfTransportSelectionButton.becomeFirstResponder()
        default:
            print("")
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case fromLocation:
            let _ = checkFromLocaion()
        case toLocation:
            let _ = checkToLocaion()
        default:
            print("")
        }
        view.endEditing(true)
    }
}
