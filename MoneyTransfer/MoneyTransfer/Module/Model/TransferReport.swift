//
//  TransferReport.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

struct TransferReport:Report, Equatable {
    var from:String
    let to:String
    let transferAmount:String
    let date:String
    let personalNotes:String?
    let messageToReceiver:String?
    
    static func == (lhs:TransferReport, rhs:TransferReport) -> Bool {
        return lhs.from == rhs.from &&
            lhs.to == rhs.to &&
            lhs.transferAmount == rhs.transferAmount &&
            lhs.date == rhs.date &&
            lhs.personalNotes == rhs.personalNotes &&
            lhs.messageToReceiver == rhs.messageToReceiver
    }
}
