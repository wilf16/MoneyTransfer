//
//  ReceiverSelectionViewModel.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

class ReceiverSelectionViewModel {
    
    lazy var items: [(name:String,bank:String,account:String)] = {
        return accounts.map({ (account) -> ((name:String,bank:String,account:String)) in
            let name = account.name
            let bank = account.bank
            let account = account.number
            return (name:name,bank:bank,account:account)
        })
    }()
    
    var accounts:[ReceivingAccount] = []
    
    var selectedAccount:(ReceivingAccount) -> Void
    init(completionHandler:@escaping (ReceivingAccount) -> Void) {
        self.selectedAccount = completionHandler
        let receiverA = ReceivingAccount(name: "Wilfred Derfliw", number: "0987654321", bank: "Pigy Bank")
        let receiverB = ReceivingAccount(name: "Batman", number: "00000001234", bank: "Bat Bank")

        accounts = [receiverA,receiverB]
    }
    
    //MARK: - External Actions
    func selectedAccount(_ index:Int)
    {
        let account = accounts[index]
        selectedAccount(account)
    }
    
}
