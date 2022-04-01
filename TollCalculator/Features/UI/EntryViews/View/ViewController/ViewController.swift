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
        self.dateTextField.text = "\(date.getDateInString())"
    }
}
