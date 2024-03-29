//
//  NewTravelDetailsViewController.swift
//  TravelPlanning
//
//  Created by Tringapps on 13/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

class NewTravelDetailsViewController: UIViewController {

    //Views
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    //Field And Buttons
    @IBOutlet weak var fromLocation: UITextField!
    @IBOutlet weak var toLocation: UITextField!
    @IBOutlet weak var dateOfTravel: UITextField!
    @IBOutlet weak var reasonForTravel: UITextView!
    @IBOutlet var modeOfTransportButtons: [UIButton]!
    @IBOutlet weak var modeOfTransportSelectionButton: UIButton!
    //Error Labels

    @IBOutlet weak var fromError: UILabel!
    @IBOutlet weak var toError: UILabel!
    @IBOutlet weak var dateError: UILabel!
    @IBOutlet weak var reasonError: UILabel!

    //Labels

    @IBOutlet var allLabels: [UILabel]!
    //DatePicker
    private var dateOfTravelPicker:UIDatePicker?

    let unwindSegue = "unwindToTravelListHomeViewController"
    let animationTimeDuration:TimeInterval = 0.3
    var isModeOfTransportSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("New Travel Details Veiw Loaded")
        initializeDatePicker()
        initializeDelegates()
        setKeyboardListeners()
        applyAllFieldThemes()
    }

    func applyAllFieldThemes() {
        scrollView.applyViewTheme()
        contentView.applyViewTheme()
        fromLocation.applyTextFieldTheme()
        toLocation.applyTextFieldTheme()
        dateOfTravel.applyTextFieldTheme()
        reasonForTravel.applyTextViewTheme()

        allLabels.forEach { (label) in
            label.textColor = CurrentTheme.FONT_COLOR
        }
    }

    func initializeDatePicker() {
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.DATE_FORMAT
        let defaultDateString = dateFormatter.string(from: todayDate)
        let defaultDate = dateFormatter.date(from: defaultDateString)
        dateOfTravelPicker = UIDatePicker()
        dateOfTravelPicker?.datePickerMode = .date
        dateOfTravelPicker?.addTarget(self, action: #selector(datechange(datepick:)), for: .valueChanged)
        dateOfTravel.inputView = dateOfTravelPicker
        dateOfTravelPicker?.date = defaultDate!
    }

    fileprivate func initializeDelegates() {
        fromLocation.delegate = self
        toLocation.delegate = self
        dateOfTravel.delegate = self
        reasonForTravel.delegate = self
    }

    @objc func  datechange(datepick:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.DATE_FORMAT
        dateOfTravel.text = dateFormatter.string(from: datepick.date)
    }

    fileprivate func setKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveScrollViewUp(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveScrollViewUp(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }

    @objc private func moveScrollViewUp(notification: Notification) {
        print("View Will Be Scrolled Up")

        guard let keyboardScreenEndFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            print("Nothing has been changed")
            return

        }
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if(notification.name == UIResponder.keyboardWillHideNotification){
            scrollView.contentInset = UIEdgeInsets.zero
            print("Scrolled Back To Normal")
        } else {
            print("Scrolling Above The Keyboard Height")
            scrollView.contentInset = UIEdgeInsets(top: CGFloat.zero, left: CGFloat.zero, bottom: keyboardViewEndFrame.height, right: CGFloat.zero)
        }
    }

    @IBAction func onClickSelectATravelMode(_ sender: Any) {
        view.endEditing(true)
        toggleButtonListHiddenProperty(withDuration: animationTimeDuration)
    }

    fileprivate func toggleButtonListHiddenProperty(withDuration duration:TimeInterval) {
        UIView.animate(withDuration:duration) {
            self.modeOfTransportButtons.forEach{(button) in
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }

    @IBAction func onClickTransportMode(_ sender: UIButton) {
        modeOfTransportSelectionButton.setTitle(sender.titleLabel?.text!, for: .normal)
        toggleButtonListHiddenProperty(withDuration: animationTimeDuration)
        isModeOfTransportSelected = true
    }

    func checkFromLocaion() -> Bool {
        let isValid = fromLocation.text!.isOfValidFormat(Regex.LOCATION)
        fromError.setStatusForLabel(ofTextField: fromLocation, ofTextView: nil, validityStatus: isValid)
        return isValid
    }

    func checkToLocaion() -> Bool {
        let isValid = toLocation.text!.isOfValidFormat(Regex.LOCATION)
        toError.setStatusForLabel(ofTextField: toLocation, ofTextView: nil, validityStatus: isValid)
        return isValid
    }

    func checkReasonForTravel() -> Bool {
        let isValid = reasonForTravel.text! != ""
        reasonError.setStatusForLabel(ofTextField: nil, ofTextView: reasonForTravel, validityStatus: isValid)
        return isValid
    }

    fileprivate func checkDateOfTravel() -> Bool {
        let isValid = dateOfTravel.text!.isOfValidFormat(Regex.VALID_DATE)
        dateError.setStatusForLabel(ofTextField: dateOfTravel, ofTextView: nil, validityStatus: isValid)
        return isValid
    }

    @IBAction func onClickDoneButton(_ sender: Any) {
        let isAllFieldsValid = checkFromLocaion() && checkToLocaion() && checkReasonForTravel() && checkDateOfTravel() && isModeOfTransportSelected
        if(isAllFieldsValid) {
            print("All Fields Are Valid")
            let newTravelModel = TravelModel(context: PersistantService.context)
            TravelListHomeViewController.allTravelDetailsMaxId = TravelListHomeViewController.allTravelDetailsMaxId + 1
            newTravelModel.id = Int16(TravelListHomeViewController.allTravelDetailsMaxId)
            newTravelModel.fromLocation = fromLocation.text!
            newTravelModel.toLocation = toLocation.text!
            newTravelModel.date = dateOfTravel.text!
            newTravelModel.modeOfTransport = modeOfTransportSelectionButton.titleLabel?.text! ?? ""
            newTravelModel.reason = reasonForTravel.text!
            TravelListHomeViewController.allTravels.append(newTravelModel)
            performSegue(withIdentifier: unwindSegue, sender: self)
            PersistantService.saveContext() 
            return
        }
        print("Invalid Fields Found")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touching Outside the View")
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onClickCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print("New Travel Details View Safe From Memory Leaks")
    }
}


//textField Delegate
extension NewTravelDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fromLocation:
            if(!checkFromLocaion()) {
                return false
            }
            toLocation.becomeFirstResponder()
        case toLocation:
            if(!checkToLocaion()) {
                return false
            }
            modeOfTransportSelectionButton.becomeFirstResponder()
        default:
            print("")
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case fromLocation:
            let _ = checkFromLocaion()
        case toLocation:
            let _ = checkToLocaion()
        default:
            print("")
        }
        view.endEditing(true)
    }
}


//textView Delegate
extension NewTravelDetailsViewController:UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        view.endEditing(true)
        let _ = checkReasonForTravel()
    }
}


//label Delegate
extension UILabel {
    public func setStatusForLabel(ofTextField textField: UITextField?, ofTextView textView:UITextView?, validityStatus IsValid:Bool) {
        self.isHidden = false
        if(IsValid) {
            self.text! = RegistrationStatus.VALID_FIELD
            self.textColor = UIColor.GREEN
            guard let textFieldUnwrapped = textField else {
                textView!.setBottomBorder(withColor: UIColor.DARK_BLUE.cgColor)
                return
            }
            textFieldUnwrapped.setBottomBorder(withColor: UIColor.DARK_BLUE.cgColor)
        } else {
            self.text! = RegistrationStatus.INVALID_FIELD
            self.textColor = UIColor.RED
            guard let textFieldUnwrapped = textField else {
                textView!.setBottomBorder(withColor: UIColor.RED.cgColor)
                return
            }
            textFieldUnwrapped.setBottomBorder(withColor: UIColor.RED.cgColor)
        }
    }
}
