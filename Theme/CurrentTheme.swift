//
//  CurrentTheme.swift
//  TravelPlanning
//
//  Created by Tringapps on 20/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
struct CurrentTheme {
    static var FONT_COLOR:UIColor!
    static var BACKGROUND_COLOR:UIColor!
    static var SHADOW_COLOR:UIColor!
    static var TINT_COLOR:UIColor!
    static var TEXTFIELD_BACKGROUND:UIColor!
    static var OVERLAY_BACKGROUND_COLOR:UIColor!
    public static func setTheme(themeToSet:Theme) {
        CurrentTheme.FONT_COLOR = themeToSet.FONT_COLOR
        CurrentTheme.BACKGROUND_COLOR = themeToSet.BACKGROUND_COLOR
        CurrentTheme.SHADOW_COLOR = themeToSet.SHADOW_COLOR
        CurrentTheme.TINT_COLOR = themeToSet.TINT_COLOR
        CurrentTheme.OVERLAY_BACKGROUND_COLOR = themeToSet.OVERLAY_BACKGROUND_COLOR
        CurrentTheme.TEXTFIELD_BACKGROUND = themeToSet.TEXTFIELD_BACKGROUND
    }
}
