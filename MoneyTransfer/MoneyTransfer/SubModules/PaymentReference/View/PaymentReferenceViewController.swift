//
//  PaymentReferenceViewController.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class PaymentReferenceViewController: UIViewController {

    var viewModel:PaymentReferenceViewModel?
    
    @IBOutlet weak var myNotesTextView: UITextView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
    }

    @IBAction func saveReference(_ sender: Any) {
        let notes:String? = myNotesTextView.text
        let message:String? = messageTextView.text
        viewModel?.saveReference(notes:notes, message:message)
    }
}
