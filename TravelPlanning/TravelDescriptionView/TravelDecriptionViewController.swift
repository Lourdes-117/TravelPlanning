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
    //Tap Gesture Recognizer
    var imageViewTapGesture:UITapGestureRecognizer!

    let editTravelText = "Edit This Travel"
    let okText = "Ok"
    var travelDetails: TravelModel!
    var indexToChange = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Travel Description View Loaded")
        setDefaultValues()
        setKeyboardNotificationListeners()
        setTextFieldDelegates()
        setTapGestureRecognizer()
        setAllFiendsEnabledStatus(withBool: false)
        initializeDatePicker()
    }

    override func viewDidAppear(_ animated: Bool) {
        for something in TravelListHomeViewController.allTravels {
            print(index)
            if(something == travelDetails){
                print(something)
                break;
            }
            indexToChange = indexToChange + 1
        }
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
        imageViewTapGesture.isEnabled = boolean
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

    func setTapGestureRecognizer() {
        imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapUIImageView(gesture:)))
        modeOfTransport.addGestureRecognizer(imageViewTapGesture)
        modeOfTransport.isUserInteractionEnabled = true
    }

    
    @objc func onTapUIImageView(gesture: UIGestureRecognizer) {
        print("My taps have been read")
    }

    @IBAction func onClickEditTravelButton(_ sender: Any) {
        print("Edit Travel Button Clicked")
        if(fromLocation.isEnabled) {
          editTravelButton.setTitle(editTravelText, for: .normal)
            setAllFiendsEnabledStatus(withBool: false)
            updateCell()
        } else {
            editTravelButton.setTitle(okText, for: .normal)
            setAllFiendsEnabledStatus(withBool: true)
        }
    }

    func updateCell(){
        var travelModelToUpdate = TravelModel()
        travelModelToUpdate.from = fromLocation.text!
        travelModelToUpdate.to = toLocation.text!
        travelModelToUpdate.date = dateOfJourney.text!
        travelModelToUpdate.reason = reasonForTravel.text!
        travelModelToUpdate.modeOfTransport = GetTravelModeImage.getString(ofImage: modeOfTransport.image!)
        TravelListHomeViewController.allTravels[indexToChange] = travelModelToUpdate
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print("Travel Description Page is Safe From Memory Leaks")
    }
}
