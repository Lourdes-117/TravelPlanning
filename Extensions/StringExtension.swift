//
//  StringExtension.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
extension String {
    public func isOfValidFormat(_ format:String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", format)
        return emailPred.evaluate(with: self)
    }
}
