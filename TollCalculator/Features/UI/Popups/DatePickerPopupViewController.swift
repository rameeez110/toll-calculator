//
//  DatePickerPopupViewController.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit
import STPopup

protocol DatePickerDelegate: NSObjectProtocol {
    func didSelectDate(date: Date)
}

class DatePickerPopupViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    weak var delegate: DatePickerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DatePickerPopupViewController", bundle: nil)
        self.contentSizeInPopup = CGSize.init(width: UIScreen.main.bounds.width, height: 260)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }

}

extension DatePickerPopupViewController {
    func setupUI() {
        self.datePicker.maximumDate = Date()
    }
}

extension DatePickerPopupViewController {
    @IBAction func didTapDone() {
        self.dismiss(animated: true) {
            self.delegate?.didSelectDate(date: self.datePicker.date)
        }
    }
}
