//
//  SendingAccount.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

struct SendingAccount:Account, Sender {
    let name:String
    let number:String
    
    var balance:Money
    
    init(name:String, number:String, balance:Money) {
        self.name = name
        self.number = number
        self.balance = balance
    }
}
