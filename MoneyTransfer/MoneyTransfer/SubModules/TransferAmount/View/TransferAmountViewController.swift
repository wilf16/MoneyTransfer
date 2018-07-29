//
//  TransferAmountViewController.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class TransferAmountViewController: UIViewController {

    var viewModel:TransferAmountViewModel?
    let pickerData:[String] = ["HKD","CNY","USD","PHP"]
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        currencyButton.backgroundColor = .white
        nextButton.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        currencyButton.setTitle(pickerData[0], for: .normal)
        currencyPickerView.frame = CGRect.init(x: 0, y: self.view.bounds.size.height,
                                               width: currencyPickerView.bounds.size.width, height: currencyPickerView.bounds.size.height)
        currencyPickerView.alpha = 0
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
    }

    @IBAction func selectCurrency(_ sender: Any) {
        if currencyPickerView.alpha == 0 {
            UIView.animate(withDuration: 1) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.currencyPickerView.alpha = 1
                weakSelf.currencyPickerView.frame = CGRect.init(x: 0,
                                                       y: weakSelf.view.bounds.size.height - weakSelf.currencyPickerView.bounds.size.height,
                                                       width: weakSelf.currencyPickerView.bounds.size.width,
                                                       height: weakSelf.currencyPickerView.bounds.size.height)
            }
        } else {
            UIView.animate(withDuration: 1) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.currencyPickerView.alpha = 0
                weakSelf.currencyPickerView.frame = CGRect.init(x: 0,
                                                                y: weakSelf.view.bounds.size.height,
                                                                width: weakSelf.currencyPickerView.bounds.size.width,
                                                                height: weakSelf.currencyPickerView.bounds.size.height)
            }
        }
    }
    
    @IBAction func acceptAmount(_ sender: Any) {
        guard let value = amountTextField.text,
            let currency = currencyButton.titleLabel?.text else { return }
        viewModel?.enteredAmount(value: value, currency: currency)
    }
}

extension TransferAmountViewController : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyButton.setTitle(pickerData[row], for: .normal)
    }
}
