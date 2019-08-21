//
//  modeOfTravelSelectionViewController.swift
//  TravelPlanning
//
//  Created by Tringapps on 14/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
class ModeOfTravelSelectionViewController: UIViewController {
    let unwindSegue = "unwindToTravelDescriptionViewControllerIdentifier"
    var selectedModeOfTransportImage:UIImage!
    @IBOutlet var modeOfTransportButtonCollection: [UIButton]!
    @IBOutlet weak var contentBackgroundView: UIView!
    override func viewDidLoad() {
        setDesigns()
        print("Mode Of Travel Selection View Controller Loaded")
    }

    func setDesigns(){
        contentBackgroundView.applyViewTheme()
        modeOfTransportButtonCollection.forEach { (button) in
            button.applyViewTheme()
            button.imageView?.applyViewTheme()
            view.backgroundColor = CurrentTheme.OVERLAY_BACKGROUND_COLOR
        }
    }

    @IBAction func onSelectModeOfTransport(_ sender: UIButton) {
        selectedModeOfTransportImage = sender.imageView?.image!
        performSegue(withIdentifier: unwindSegue, sender: self)
    }

    @IBAction func onClickCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touching Outside the View")
        self.dismiss(animated: true, completion: nil)
    }

    deinit {
        print("Mode Of Travel Selection View Controller Is Safe From Memory Leaks")
    }
}
