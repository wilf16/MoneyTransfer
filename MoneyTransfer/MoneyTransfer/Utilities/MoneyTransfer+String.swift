//
//  MoneyTransfer+String.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

extension String {
    var toDate:Date? {
         let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.date(from: self)
    }
}
