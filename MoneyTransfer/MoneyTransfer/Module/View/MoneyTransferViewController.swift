//
//  MoneyTransferViewController.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class MoneyTransferViewController: UIViewController {
    var viewModel:MoneyTransferModuleInput?
    
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var referenceButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    
    deinit {
        print("View")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Money Transfer"
        
        fromButton.imageEdgeInsets = UIEdgeInsetsMake(0, fromButton.bounds.size.width - 35, 0, 0)
        toButton.imageEdgeInsets = UIEdgeInsetsMake(0, toButton.bounds.size.width - 35, 0, 0)
        amountButton.imageEdgeInsets = UIEdgeInsetsMake(0, amountButton.bounds.size.width - 35, 0, 0)
        referenceButton.imageEdgeInsets = UIEdgeInsetsMake(0, referenceButton.bounds.size.width - 35, 0, 0)
        transferButton.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
    }
    // MARK: - Helper Methods
    func clearData() {
        self.fromLabel.text = nil
        self.nameLabel.text = nil
        self.toLabel.text = nil
        self.amountLabel.text = nil
    }
    //MARK: - IBActions
    @IBAction func selectSender(_ sender: Any) {
        viewModel?.selectSender(completionHanlder:{ [weak self] (sender) in
            self?.fromLabel.text = sender
        })
    }
    
    @IBAction func selectReceiver(_ sender: Any) {
        viewModel?.selectReceiver(completionHanlder: { [weak self] (name,bank) in
            self?.nameLabel.text = name
            self?.toLabel.text = bank
        })
    }
    
    @IBAction func inputAmount(_ sender: Any) {
        viewModel?.selectAmount(completionHanlder: { [weak self] (amount) in
            self?.amountLabel.text = amount
        })
    }
    
    @IBAction func inputPaymentReference(_ sender: Any) {
        viewModel?.createReference()
    }
    
    @IBAction func transferMoney(_ sender: Any) {
        viewModel?.transfer()
    }
}
