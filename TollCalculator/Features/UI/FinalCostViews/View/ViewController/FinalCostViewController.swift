//
//  FinalCostViewController.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

class FinalCostViewController: UIViewController {
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var viewModel: FinalCostViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - Delegates

extension FinalCostViewController: FinalCostViewModelDelegate {
    func alert(with title: String, message: String) {

    }
}
