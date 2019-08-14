//
//  AlertCreator.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
class AlertCreator{
    public class func createAlert(title:String, message:String ,buttonTitle:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: buttonTitle, style: .destructive, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(dismissButton)
        return alert
    }
}
