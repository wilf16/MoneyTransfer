//
//  PaymentReferenceViewModel.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
class PaymentReferenceViewModel {
    
    var referenceEntered:(PaymentReference?) -> Void
    init(completionHandler:@escaping (PaymentReference?) -> Void) {
        self.referenceEntered = completionHandler
    }
    
    //MARK: - External Actions
    func saveReference(notes:String?, message:String?)
    {
        if notes == nil && message == nil {
            self.referenceEntered(nil)
            return
        }
        let reference = PaymentReference(notes: notes, message: message)
        self.referenceEntered(reference)
    }
}
