//
//  MockedMoneyTransferViewModel.swift
//  MoneyTransferTests
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
@testable import MoneyTransfer

//class MockedMoneyTransferViewModel: MoneyTransferViewModel {
//    
//    enum MoneyTransferBehavior {
//        case validateData
//        case createTransactionParameter
//        case runTransaction
//        case generateReport
//    }
//    var actions:[MoneyTransferBehavior] = []
//    
//    override init() {
//        super.init()
//        //default given
//    }
//    override func transferMoney(completionHandler: @escaping (Report?, Error?) -> Void) {
//        
//        //Uncomment for testing ideal scenario
//        //        actions = [.validateData, .createTransactionParameter, .runTransaction, .generateReport]
//        //        let report = TransferReport(from: "Wilf", to: "Me", transferAmount: "1,000,000.00 HKD", date: "Now", personalNotes: "Lol!", messageToReceiver: "Save it!")
//        //        completionHandler(report, nil)
//        
//        actions = []
//        super.transferMoney(completionHandler: completionHandler)
//    }
//    override func validateTransferData() throws -> (sender: SendingAccount, receiver: ReceivingAccount, amount: TransferAmount) {
//        do {
//            actions.append(.validateData)
//            return try super.validateTransferData()
//        } catch let error {
//            throw error
//        }
//    }
//    override func constructTransactionTask(withSender sender: SendingAccount, receiver: ReceivingAccount, amount: TransferAmount, reference: PaymentReference?) throws -> MoneyTransferRequest {
//        do {
//            actions.append(.createTransactionParameter)
//            let _ = try super.constructTransactionTask(withSender: sender, receiver: receiver, amount: amount, reference: reference)
//            
//            //Fake Request
//            let mockedTask = MockedMoneyTransferTask(data: [:])
//            
//            return mockedTask
//        } catch let error {
//            throw error
//        }
//    }
//    override func runTransaction(withTask task: MoneyTransferRequest, completionHandler: @escaping (([String : Any]?, Error?) -> Void)) {
//        actions.append(.runTransaction)
//        super.runTransaction(withTask: task, completionHandler: completionHandler)
//    }
//    override func generateReport(fromDictionary dict: [String : Any]) throws -> Report {
//        actions.append(.generateReport)
//        do {
//            return try super.generateReport(fromDictionary:dict)
//        } catch let error {
//            throw error
//        }
//        
//    }
//}
