//
//  SenderSelectionViewModel.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

class SenderSelectionViewModel {
    
    lazy var items: [(account:String,number:String,balance:String)] = {
        return accounts.map({ (account) -> (account:String,number:String,balance:String) in
            let name = account.name
            let number = account.number
            let balance = "\(account.balance.value) \(account.balance.currency)"
            return (account:name,number:number,balance:balance)
        })
    }()
  
    
    var accounts:[SendingAccount] = []
    
    var selectedAccount:(SendingAccount) -> Void
    init(completionHandler:@escaping (SendingAccount) -> Void) {
        self.selectedAccount = completionHandler
        let balanceA = Balance(value: 100_000.00, currency: "HKD")
        let senderA = SendingAccount(name: "Pigy Super Savings", number: "1234567890", balance: balanceA)
        
        let balanceB = Balance(value: 1_000_000.00, currency: "PHP")
        let senderB = SendingAccount(name: "Turtle Super Savings", number: "2468101214", balance: balanceB)
        accounts = [senderA,senderB]
    }
    
    //MARK: - External Actions
    func selectedAccount(_ index:Int)
    {
        let account = accounts[index]
        selectedAccount(account)
    }
    
}
