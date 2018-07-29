//
//  TransferAmountViewModel.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
class TransferAmountViewModel {
    
    var amountEntered:(TransferAmount) -> Void
    init(completionHandler:@escaping (TransferAmount) -> Void) {
        self.amountEntered = completionHandler
    }
    
    //MARK: - External Actions
    func enteredAmount(value:String, currency:String)
    {
        guard let doubleValue = Double(value) else { return }
        let amount = TransferAmount(value: doubleValue, currency: currency)
        self.amountEntered(amount)
    }
}
