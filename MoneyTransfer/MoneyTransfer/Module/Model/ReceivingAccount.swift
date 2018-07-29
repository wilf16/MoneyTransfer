//
//  ReceivingAccount.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

struct ReceivingAccount: Receiver {
    let name:String
    let number:String
    
    let bank:String
    
    init(name:String, number:String, bank:String) {
        self.name = name
        self.number = number
        self.bank = bank
    }
}
