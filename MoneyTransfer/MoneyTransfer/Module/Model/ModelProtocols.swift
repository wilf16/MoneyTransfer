//
//  ModelProtocols.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

protocol Account {
    var name:String { get }
    var number:String { get }
}

protocol Money {
    var value:Double { get }
    var currency:String { get }
}

protocol Sender {
    var balance:Money { get set }
}

protocol Receiver: Account {
    var bank:String { get }
}

protocol Notes {
    var notes:String? { get set }
    var message:String? { get set }
}

protocol Report {
    var from:String { get }
    var to:String { get }
    var transferAmount:String { get }
    var date:String { get }
    var personalNotes:String? { get }
    var messageToReceiver:String? { get }
}
