//
//  TravelDecriptionViewController.swift
//  TravelPlanning
//
//  Created by Tringapps on 13/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

class TravelDecriptionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var modeOfTransport: UIImageView!
    @IBOutlet weak var dateOfJourney: UITextField!
    @IBOutlet weak var fromLocation: UITextField!
    @IBOutlet weak var toLocation: UITextField!
    @IBOutlet weak var reasonForTravel: UITextView!
    @IBOutlet weak var editTravelButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    //DatePicker
    private var dateOfJourneyPicker:UIDatePicker?

    let editTravelText = "Edit This Travel"
    let okText = "Ok"
    var travelDetails: TravelModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Travel Description View Loaded")
        setDefaultValues()
        setKeyboardNotificationListeners()
        setTextFieldDelegates()
        setAllFiendsEnabledStatus(withBool: false)
        initializeDatePicker()
    }

    private func setKeyboardNotificationListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveScrollViewUp(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveScrollViewUp(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }

    @objc private func moveScrollViewUp(notification: Notification) {
        print("This will change the view")

        guard let keyboardScreenEndFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if(notification.name == UIResponder.keyboardWillHideNotification){
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: CGFloat.zero, left: CGFloat.zero, bottom: keyboardViewEndFrame.height, right: CGFloat.zero)
        }
    }

    private func setTextFieldDelegates() {
        dateOfJourney.delegate = self
        fromLocation.delegate = self
        toLocation.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func setDefaultValues() {
        modeOfTransport.image = GetTravelModeImage.getImage(ofString: travelDetails.modeOfTransport)
        dateOfJourney.text = travelDetails.date
        fromLocation.text = travelDetails.from
        toLocation.text = travelDetails.to
        reasonForTravel.text = travelDetails.reason
    }

    func setAllFiendsEnabledStatus(withBool boolean:Bool) {
        dateOfJourney.isEnabled = boolean
        fromLocation.isEnabled = boolean
        toLocation.isEnabled = boolean
        reasonForTravel.isEditable = boolean
    }

    func initializeDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.DATE_FORMAT.rawValue
        let defaultDate = dateFormatter.date(from: dateOfJourney.text!)
        dateOfJourneyPicker = UIDatePicker()
        dateOfJourneyPicker?.datePickerMode = .date
        dateOfJourneyPicker?.addTarget(self, action: #selector(datechange(datepick:)), for: .valueChanged)
        dateOfJourney.inputView = dateOfJourneyPicker
        dateOfJourneyPicker?.date = defaultDate!
    }

    @objc func  datechange(datepick:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.DATE_FORMAT.rawValue
        dateOfJourney.text = dateFormatter.string(from: datepick.date)
    }

    @IBAction func onClickEditTravelButton(_ sender: Any) {
        print("Edit Travel Button Clicked")
        if(fromLocation.isEnabled) {
          editTravelButton.setTitle(editTravelText, for: .normal)
            setAllFiendsEnabledStatus(withBool: false)
        } else {
            editTravelButton.setTitle(okText, for: .normal)
            setAllFiendsEnabledStatus(withBool: true)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print("Travel Description Page is Safe From Memory Leaks")
    }
}
