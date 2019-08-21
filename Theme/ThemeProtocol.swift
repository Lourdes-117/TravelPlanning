//
//  ThemeProtocol.swift
//  TravelPlanning
//
//  Created by Tringapps on 20/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
protocol Theme {
    var FONT_COLOR:UIColor { get }
    var BACKGROUND_COLOR:UIColor { get }
    var SHADOW_COLOR:UIColor { get }
    var TINT_COLOR:UIColor { get }
    var OVERLAY_BACKGROUND_COLOR:UIColor { get }
    var TEXTFIELD_BACKGROUND:UIColor { get }
}
