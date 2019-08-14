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
    //Error
    @IBOutlet weak var dateError: UILabel!
    @IBOutlet weak var fromError: UILabel!
    @IBOutlet weak var toError: UILabel!
    @IBOutlet weak var reasonError: UILabel!
    //DatePicker
    private var dateOfJourneyPicker:UIDatePicker?
    //Tap Gesture Recognizer
    var imageViewTapGesture:UITapGestureRecognizer!

    let modeOfTravelSelectionSegueIdentifier = "ModeOfTravelSelectionViewSegueIdentifier"
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
        applyDesigns()
    }

    func applyDesigns() {
        fromLocation.applyTextFieldTheme()
        toLocation.applyTextFieldTheme()
        dateOfJourney.applyTextFieldTheme()
        reasonForTravel.applyTextViewTheme()
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
        performSegue(withIdentifier: modeOfTravelSelectionSegueIdentifier, sender: self)
    }

    @IBAction func onClickEditTravelButton(_ sender: Any) {
        print("Edit Travel Button Clicked")
        if(fromLocation.isEnabled) {
            if(!isAllFieldsValid()) {
                let invalidFieldAlert = AlertCreator.createAlert(title: "Invalid Fields", message: "Invalid Fields Founds. Please Check Again", buttonTitle: "Ok")
                self.present(invalidFieldAlert, animated: true, completion: nil)
                return
            }
            self.modeOfTransport.removeViewTheme()
            updateCell()
            editTravelButton.setTitle(editTravelText, for: .normal)
            setAllFiendsEnabledStatus(withBool: false)
        } else {
            self.modeOfTransport.applyViewTheme()
            editTravelButton.setTitle(okText, for: .normal)
            setAllFiendsEnabledStatus(withBool: true)
        }
    }

    func isAllFieldsValid() -> Bool {
        let isAllFieldsValid = checkFromLocaion() && checkToLocaion() && checkReasonForTravel() && checkDateOfTravel()
        return isAllFieldsValid
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

    func checkFromLocaion() -> Bool{
        let isValid = fromLocation.text!.isOfValidFormat(Regex.LOCATION.rawValue)
        fromError.setStatusForLabel(ofTextField: fromLocation, ofTextView: nil, validityStatus: isValid)
        return isValid
    }

    func checkToLocaion() -> Bool{
        let isValid = toLocation.text!.isOfValidFormat(Regex.LOCATION.rawValue)
        toError.setStatusForLabel(ofTextField: toLocation, ofTextView: nil, validityStatus: isValid)
        return isValid
    }

    func checkReasonForTravel() -> Bool{
        let isValid = reasonForTravel.text! != ""
        reasonError.setStatusForLabel(ofTextField: nil, ofTextView: reasonForTravel, validityStatus: isValid)
        return isValid
    }

    func checkDateOfTravel() -> Bool {
        let isValid = dateOfJourney.text!.isOfValidFormat(Regex.VALID_DATE.rawValue)
        dateError.setStatusForLabel(ofTextField: dateOfJourney, ofTextView: nil, validityStatus: isValid)
        return isValid
    }

    @IBAction func unwindToTravelDescriptionViewController(_ unwindSegue: UIStoryboardSegue) {
        if let modeOfTravelSelectionViewController = unwindSegue.source as? ModeOfTravelSelectionViewController {
            let selectedModeOfTransportImage = modeOfTravelSelectionViewController.selectedModeOfTransportImage
            guard let selectedModeOfTransportImageUnwrapped = selectedModeOfTransportImage else {return}
            modeOfTransport.image = selectedModeOfTransportImageUnwrapped
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print("Travel Description Page is Safe From Memory Leaks")
    }
}
