//
//  ViewModelProtocols.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

protocol MoneyTransferModule {
    
    // MARK: Subject for stubbing
    var sender:SendingAccount? { get set }
    var receiver:ReceivingAccount? { get set }
    var amount:TransferAmount? { get set }
    var reference:PaymentReference? { get set }
    
    // MARK: - External Actions Subject for Integration Testing
    func transferMoney(completionHandler:@escaping (Report?, Error?) -> Void)
    
    // MARK: - Helper Methods Subject for Unit Testing
    func validateTransferData() throws -> (sender:SendingAccount, receiver:ReceivingAccount, amount:TransferAmount)
    func constructTransactionTask(withSender sender:SendingAccount, receiver:ReceivingAccount, amount:TransferAmount, reference:PaymentReference?) throws -> MoneyTransferRequest
    func runTransaction(withTask task:MoneyTransferRequest, completionHandler: @escaping ((_ data:[String:Any]?, _ error:Error?) -> Void))
    func generateReport(fromDictionary dict:[String:Any]) throws -> Report
}

protocol MoneyTransferModuleInput {
    func selectSender(completionHanlder:@escaping((String) -> Void))
    func selectReceiver(completionHanlder:@escaping((String,String) -> Void))
    func selectAmount(completionHanlder:@escaping((String) -> Void))
    func createReference()
    func transfer()
}

protocol MoneyTransferModuleOutput {
    func showTransactionReport(_ report:TransferReport)
    func showTransactionError(_ error:Error)
}
