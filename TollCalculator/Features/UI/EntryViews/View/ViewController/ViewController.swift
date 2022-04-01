//
//  ViewController.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: EntryViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("call ho gaya hun")
    }
    
}

//MARK: - Delegates

extension ViewController: EntryViewModelDelegate {
    func alert(with title: String, message: String) {
//        self.infoLabel.isHidden = false
//        self.infoLabel.text = message
    }
    func validationError(error: String) {
//        self.infoLabel.isHidden = false
//        self.infoLabel.text = error
    }
}

