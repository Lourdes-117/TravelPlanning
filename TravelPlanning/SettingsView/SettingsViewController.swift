//
//  SwttingsViewController.swift
//  TravelPlanning
//
//  Created by Tringapps on 21/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
import UIKit
class SettingsViewController: UIViewController {
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSwitchPosition()
        applyTheme()
        print("Settings View Has Been Loaded")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Settings View Will Appear")
    }

    fileprivate func setDefaultSwitchPosition() {
        if(UserDefaults.standard.bool(forKey: Defaults.IS_DARK_THEME_PREFERRED)) {
            darkThemeSwitch.isOn = true
        }
    }

    @IBAction func onThemeChange(_ sender: UISwitch) {
        if(sender.isOn) {
            UserDefaults.standard.set(true, forKey: Defaults.IS_DARK_THEME_PREFERRED)
            CurrentTheme.setTheme(themeToSet: DarkTheme())
        } else {
            UserDefaults.standard.set(false, forKey: Defaults.IS_DARK_THEME_PREFERRED)
            CurrentTheme.setTheme(themeToSet: LightTheme())
        }
        applyTheme()
    }

    fileprivate func applyTheme() {
        let animationDuration:TimeInterval = 0.4
        navigationController?.navigationBar.barTintColor = CurrentTheme.BACKGROUND_COLOR
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: CurrentTheme.FONT_COLOR!]
        UIView.animate(withDuration: animationDuration) {
            self.view.layer.backgroundColor = CurrentTheme.BACKGROUND_COLOR.cgColor
            self.allLabels.forEach { (label) in
                label.textColor = CurrentTheme.FONT_COLOR
            }
        }
    }

    @IBAction func onClickRefreshButton(_ sender: Any) {
        for entry in TravelListHomeViewController.allTravels {
            PersistantService.context.delete(entry)
        }
        TravelListHomeViewController.allTravels.removeAll()
        let urlToFetchData:String = "https://api.myjson.com/bins/14u2y7"
        setAllTravelsData.getDataFromAPI(urlToFetchData: urlToFetchData, dispatchGroup: DispatchGroup())
    }
}
