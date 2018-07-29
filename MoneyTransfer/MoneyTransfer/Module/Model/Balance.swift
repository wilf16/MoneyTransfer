//
//  Balance.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

struct Balance:Money {
    var value: Double
    var currency: String
    
    init(value:Double, currency:String) {
        self.value = value
        self.currency = currency
    }
}
