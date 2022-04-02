//
//  ViewController.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit
import STPopup

class ViewController: UIViewController {
    
    @IBOutlet weak var interchangeTextField: UITextField!
    @IBOutlet weak var numberPlateTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var viewModel: EntryViewModelProtocol?
    var popupVC = STPopupController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupInfo(status: true)
        self.setupUI()
    }
    
}

extension ViewController {
    func setupUI() {
        self.numberPlateTextField.text = self.viewModel?.tollModel.numberPlate
        if self.viewModel?.selectedScreenType == .Entry {
            self.title = "Entry"
            self.submitButton.setTitle("Submit", for: .normal)
        } else {
            self.title = "Exit"
            self.submitButton.setTitle("Calculate", for: .normal)
        }
    }
    func setupInfo(status: Bool) {
        self.infoLabel.isHidden = status
    }
    func initializePopup(viewController: UIViewController){
        popupVC = STPopupController.init(rootViewController: viewController)
        popupVC.containerView.backgroundColor = UIColor.clear
        let blur = UIBlurEffect.init(style: .dark)
        popupVC.style = .formSheet
        popupVC.backgroundView = UIVisualEffectView.init(effect: blur)
        popupVC.backgroundView?.alpha = 0.9
        popupVC.setNavigationBarHidden(true, animated: true)
        popupVC.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
        popupVC.present(in: self)
    }
    // function which is triggered when handleTap is called
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        popupVC.dismiss()
    }
}

//MARK: - IBActions
extension ViewController {
    @IBAction func didTapSubmit() {
        self.viewModel?.didTapSubmit(interchange: self.interchangeTextField.text!, numberPlate: self.numberPlateTextField.text!, date: self.dateTextField.text!)
    }
    @IBAction func didTapInterchange() {
        let sheet = UIAlertController.init(title: "", message: "Please select interchange", preferredStyle: UIAlertController.Style.actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            //Cancel Action
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.ZeroPoint.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.ZeroPoint.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.ZeroPoint)
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.NS.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.NS.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.NS)
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.Ph4.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.Ph4.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.Ph4)
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.Ferozpur.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.Ferozpur.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.Ferozpur)
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.LakeCity.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.LakeCity.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.LakeCity)
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.Raiwand.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.Raiwand.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.Raiwand)
        }))
        sheet.addAction(UIAlertAction(title: InterchangeTypes.Bahria.rawValue,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.interchangeTextField.text = InterchangeTypes.Bahria.rawValue
            self.viewModel?.updateEntryOrExitInterchange(type: InterchangeTypes.Bahria)
        }))
        CommonClass.sharedInstance.showSheet(sheet: sheet, sender: UIButton(), owner: self)
    }
    @IBAction func didTapDate() {
        let vc = DatePickerPopupViewController(nibName: "DatePickerPopupViewController", bundle: nil)
        vc.delegate = self
        self.initializePopup(viewController: vc)
    }
}

//MARK: - Delegates

extension ViewController: EntryViewModelDelegate {
    func alert(with title: String, message: String) {
        self.setupInfo(status: false)
        self.infoLabel.text = message
    }
    func validationError(error: String) {
        self.setupInfo(status: false)
        self.infoLabel.text = error
    }
    func hideInfoLabel() {
        self.setupInfo(status: true)
    }
}

extension ViewController: DatePickerDelegate{
    func didSelectDate(date: Date) {
        if self.viewModel?.selectedScreenType == .Entry {
            self.viewModel?.tollModel.entryDate = date
        } else {
            self.viewModel?.tollModel.exitDate = date
        }
        self.dateTextField.text = "\(date.getDateInString())"
    }
}
