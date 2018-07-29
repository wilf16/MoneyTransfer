//
//  MoneyTransferReportViewController.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class MoneyTransferReportViewController: UIViewController {

    var viewModel:MoneyTransferReportViewModel?
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var transferAmountLabel: UILabel!
    @IBOutlet weak var transferDateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        fromLabel.text = viewModel?.from
        toLabel.text = viewModel?.to
        transferAmountLabel.text = viewModel?.amount
        transferDateLabel.text = viewModel?.date
        notesLabel.text = viewModel?.notes
        messageLabel.text = viewModel?.message
    }


    @IBAction func doneTransferReport(_ sender: Any) {
        viewModel?.doneWithReport()
    }
    
}
