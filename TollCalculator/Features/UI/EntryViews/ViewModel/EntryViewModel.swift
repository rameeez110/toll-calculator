//
//  EntryViewModel.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol EntryViewModelDelegate: class {
    func alert(with title: String, message: String)
    func validationError(error: String)
    func hideInfoLabel()
}

// Protocol for view model will use it for wiring
protocol EntryViewModelProtocol {

    var delegate: EntryViewModelDelegate? { get set }
    var selectedScreenType: TollScreenType { get set }
    
    func didTapSubmit(interchange: String,numberPlate: String,date: String)
}

final class EntryViewModel: EntryViewModelProtocol {

    weak var delegate: EntryViewModelDelegate?
    private let navigator: EntryNavigatorProtocol
    var selectedScreenType: TollScreenType

    init(type: TollScreenType,navigator: EntryNavigatorProtocol, delegate: EntryViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
        self.selectedScreenType = type
    }

    func didTapSubmit(interchange: String,numberPlate: String,date: String) {
        let (status,string) = self.validateFields(interchange: interchange,numberPlate: numberPlate,date: date)
        if status {
            self.delegate?.hideInfoLabel()
            if self.selectedScreenType == .Entry {
                navigator.navigateToSubmit()
            } else {
                navigator.navigateToCalculate()
            }
        } else {
            self.delegate?.validationError(error: string)
        }
    }
    func validateFields(interchange: String,numberPlate: String,date: String) -> (Bool,String) {
        var string = ""
        if interchange.isEmpty {
            string = "Please enter interchange"
            return (false,string)
        }
        
        if numberPlate.isEmpty {
            string = "Please enter number plate"
            return (false,string)
        }
        
        if date.isEmpty {
            string = "Please select date"
            return (false,string)
        }
        return (true,"")
    }
}
