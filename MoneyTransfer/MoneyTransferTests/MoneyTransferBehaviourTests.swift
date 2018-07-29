//
//  MoneyTransferTests.swift
//  MoneyTransferTests
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import XCTest
@testable import MoneyTransfer

class MoneyTransferBehaviourTests: XCTestCase {
    
    class MockedMoneyTransferViewModel: MoneyTransferViewModel {

        enum MoneyTransferBehavior {
            case validateData
            case createTransactionParameter
            case runTransaction
            case generateReport
        }
        var actions:[MoneyTransferBehavior] = []
        override func validateTransferData() throws -> (sender: SendingAccount, receiver: ReceivingAccount, amount: TransferAmount) {
            actions.append(.validateData)
            let balance = Balance(value: 100_000, currency: "HKD")
            let sender = SendingAccount(name: "Pigy Super Savings", number: "1234567890", balance: balance)
            let amount = TransferAmount(value: 30_000.0, currency: "HKD")
            let receiver = ReceivingAccount(name: "Wilfred Derfliw", number: "0987654321", bank: "Pigy Bank")
            
            return (sender: sender, receiver: receiver, amount: amount)
        }
        override func constructTransactionTask(withSender sender: SendingAccount, receiver: ReceivingAccount, amount: TransferAmount, reference: PaymentReference?) throws -> MoneyTransferRequest {
                actions.append(.createTransactionParameter)
                let mockedTask = MockedMoneyTransferTask(data: [:])
                return mockedTask
        }
        override func runTransaction(withTask task: MoneyTransferRequest, completionHandler: @escaping (([String : Any]?, Error?) -> Void)) {
            actions.append(.runTransaction)
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource:"MoneyTransferDummyReport", ofType:"json")
            let url = URL(fileURLWithPath: path!)
            let jsonData = try? Data(contentsOf: url)
            let json = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments)
            let data = json as! [String:Any]
            let dict = data["data"] as? [String:Any]
            completionHandler(dict,nil)
        }
        override func generateReport(fromDictionary dict: [String : Any]) throws -> Report {
            actions.append(.generateReport)
            let expectedReport:TransferReport = TransferReport(from: "from", to: "to", transferAmount: "amount", date: "date", personalNotes: "personalNotes", messageToReceiver: "message")
            return expectedReport
        }
    }

    var moneyTransferModule:MockedMoneyTransferViewModel!
    
    override func setUp() {
        super.setUp()
        moneyTransferModule = MockedMoneyTransferViewModel()
    }
    
    override func tearDown() {
        moneyTransferModule = nil
        super.tearDown()
    }
    
    func testMoneyTransferBehavior()
    {
        //given
        moneyTransferModule.actions = []
        
        //when
        moneyTransferModule.transfer()
       
        //Then
        XCTAssertEqual(moneyTransferModule.actions, [.validateData,.createTransactionParameter,.runTransaction,.generateReport])
    }

    
}
