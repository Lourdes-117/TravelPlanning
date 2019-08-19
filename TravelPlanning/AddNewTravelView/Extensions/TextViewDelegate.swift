//
//  TextViewDelegate.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
extension NewTravelDetailsViewController:UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        view.endEditing(true)
        let _ = checkReasonForTravel()
    }
}
