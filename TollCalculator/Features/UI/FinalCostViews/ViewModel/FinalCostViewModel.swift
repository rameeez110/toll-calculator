//
//  FinalCostViewModel.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol FinalCostViewModelDelegate: class {
    func alert(with title: String, message: String)
}

// Protocol for view model will use it for wiring
protocol FinalCostViewModelProtocol {

    var delegate: FinalCostViewModelDelegate? { get set }
}

final class FinalCostViewModel: FinalCostViewModelProtocol {

    weak var delegate: FinalCostViewModelDelegate?
    private let navigator: FinalCostNavigatorProtocol

    init(navigator: FinalCostNavigatorProtocol, delegate: FinalCostViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }
}
