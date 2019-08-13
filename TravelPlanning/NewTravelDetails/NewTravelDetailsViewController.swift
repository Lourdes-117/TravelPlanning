//
//  NewTravelDetailsViewController.swift
//  TravelPlanning
//
//  Created by Tringapps on 13/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

class NewTravelDetailsViewController: UIViewController {

    @IBOutlet weak var fromLocation: UITextField!
    @IBOutlet weak var toLocation: UITextField!
    @IBOutlet weak var dateOfTravel: UITextField!
    @IBOutlet weak var reasonOfTravel: UITextView!
    @IBOutlet var modeOfTransportButtons: [UIButton]!
    @IBOutlet weak var modeOfTransportSelectionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("New Travel Details Veiw Loaded")
    }

    @IBAction func onClickSelectATravelMode(_ sender: Any) {
        toggleButtonListHiddenProperty(withDuration: 0.3)
    }

    func toggleButtonListHiddenProperty(withDuration duration:TimeInterval){
        UIView.animate(withDuration: duration) {
            self.modeOfTransportButtons.forEach{(button) in
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func onClickTransportMode(_ sender: UIButton) {
        modeOfTransportSelectionButton.setTitle(sender.titleLabel?.text!, for: .normal)
        toggleButtonListHiddenProperty(withDuration: 0.3)
    }

    deinit {
        print("New Travel Details View Safe From Memory Leaks")
    }
}
