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
        
        self.viewModel?.getTrips()
    }

}

//MARK: - Delegates

extension FinalCostViewController: FinalCostViewModelDelegate {
    func updateUI(trip: Trips,model: TollModel) {
        self.totalAmountLabel.text = "\(trip.totalCost) Rs"
        self.rateLabel.text = "20 Rs"
        self.discountLabel.text = "\(model.discount) %"
        self.distanceLabel.text = "\(abs(model.exitDistance - model.entryDistance)) covered"
    }
    
    func alert(with title: String, message: String) {

    }
}
