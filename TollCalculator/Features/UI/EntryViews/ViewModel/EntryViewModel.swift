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
}

// Protocol for view model will use it for wiring
protocol EntryViewModelProtocol {

    var delegate: EntryViewModelDelegate? { get set }

    func didTapSubmit()
}

final class EntryViewModel: EntryViewModelProtocol {

    weak var delegate: EntryViewModelDelegate?

    private let navigator: EntryNavigatorProtocol

    init(navigator: EntryNavigatorProtocol, delegate: EntryViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }

    func didTapSubmit() {
        navigator.navigateToSubmit()
    }
}
