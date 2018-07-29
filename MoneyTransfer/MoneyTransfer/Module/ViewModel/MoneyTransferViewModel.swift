//
//  MoneyTransferViewModel.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
class MoneyTransferViewModel:MoneyTransferModule, MoneyTransferModuleInput, MoneyTransferModuleOutput {
    
    weak var wireframe:MoneyTransferWireframe?
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    var sender: SendingAccount?
    var receiver: ReceivingAccount?
    var amount: TransferAmount?
    var reference: PaymentReference?
    
    var senderSelectionWireframe:SenderSelectionWireframe?
    var receiverSelectionWireframe:ReceiverSelectionWireframe?
    var transferAmountWireframe:TransferAmountWireframe?
    var paymentReferenceWireframe:PaymentReferenceWireframe?
    var transferReportWireframe:MoneyTransferReportWireframe?
    
    deinit {
        print("ViewModel")
    }
    init() {
        
    }
    // MARK: - Internal Actions
    func showTransactionReport(_ report:TransferReport)
    {
        guard let module = wireframe else { return }
        do {
            transferReportWireframe = MoneyTransferReportWireframe(report: report) { [weak self] () in
                guard let weakSelf = self, let moneyTransferModule = weakSelf.wireframe, let transferReportWireframe = weakSelf.transferReportWireframe else { return }
                
                weakSelf.sender = nil
                weakSelf.receiver = nil
                weakSelf.amount = nil
                weakSelf.reference = nil
                moneyTransferModule.clearData()
                moneyTransferModule.popSubModule(withWireframe: transferReportWireframe, animated: true, completion: { [weak self] in
                    self?.transferReportWireframe = nil
                })
            }
            try module.pushSubModule(withWireframe: transferReportWireframe!, animated: true, completion: nil)
        } catch {
            self.transferReportWireframe = nil
        }
    }
    func showTransactionError(_ error:Error)
    {
        self.wireframe?.showAlertView(title:"Error", message:"\(error.localizedDescription)")
    }
    // MARK: - External Actions
    func selectSender(completionHanlder:@escaping ((String) -> Void))
    {
        guard let module = wireframe else { return }
        do {
            senderSelectionWireframe = SenderSelectionWireframe { [weak self] (account) in
                guard let weakSelf = self, let moneyTransferModule = weakSelf.wireframe, let senderSelectionModule = weakSelf.senderSelectionWireframe else { return }
                
                weakSelf.sender = account
                
                let sender = """
                \(account.name)
                \(account.number)
                \(account.balance.value) \(account.balance.currency)
                """
                completionHanlder(sender)
                
                moneyTransferModule.popSubModule(withWireframe: senderSelectionModule, animated: true, completion: { [weak self] in
                    self?.senderSelectionWireframe = nil
                })
            }
            try module.pushSubModule(withWireframe: senderSelectionWireframe!, animated: true, completion: nil)
        } catch {
            self.senderSelectionWireframe = nil
        }
    }
    func selectReceiver(completionHanlder:@escaping((String,String) -> Void))
    {
        guard let module = wireframe else { return }
        do {
            receiverSelectionWireframe = ReceiverSelectionWireframe { [weak self] (account) in
                guard let weakSelf = self, let moneyTransferModule = weakSelf.wireframe, let receiverSelectionModule = weakSelf.receiverSelectionWireframe else { return }
                
                weakSelf.receiver = account
                let name = account.name.uppercased()
                let bank = """
                \(account.bank)
                \(account.number)
                """
                completionHanlder(name,bank)
                
                moneyTransferModule.popSubModule(withWireframe: receiverSelectionModule, animated: true, completion: { [weak self] in
                    self?.receiverSelectionWireframe = nil
                })
            }
            try module.pushSubModule(withWireframe: receiverSelectionWireframe!, animated: true, completion: nil)
        } catch {
            self.receiverSelectionWireframe = nil
        }
    }
    func selectAmount(completionHanlder:@escaping((String) -> Void))
    {
        guard let module = wireframe else { return }
        do {
            transferAmountWireframe = TransferAmountWireframe { [weak self] (amount) in
                guard let weakSelf = self, let moneyTransferModule = weakSelf.wireframe, let transferAmountWireframe = weakSelf.transferAmountWireframe else { return }
                weakSelf.amount = amount

                let transferAmout = "\(amount.value) \(amount.currency)"
                completionHanlder(transferAmout)
                
                moneyTransferModule.popSubModule(withWireframe: transferAmountWireframe, animated: true, completion: { [weak self] in
                    self?.transferAmountWireframe = nil
                })
            }
            try module.pushSubModule(withWireframe: transferAmountWireframe!, animated: true, completion: nil)
        } catch {
            self.transferAmountWireframe = nil
        }
    }
    func createReference()
    {
        guard let module = wireframe else { return }
        do {
            paymentReferenceWireframe = PaymentReferenceWireframe { [weak self] (reference) in
                guard let weakSelf = self, let moneyTransferModule = weakSelf.wireframe, let paymentReferenceWireframe = weakSelf.paymentReferenceWireframe else { return }
                weakSelf.reference = reference
                
                moneyTransferModule.popSubModule(withWireframe: paymentReferenceWireframe, animated: true, completion: { [weak self] in
                    self?.paymentReferenceWireframe = nil
                })
            }
            try module.pushSubModule(withWireframe: paymentReferenceWireframe!, animated: true, completion: nil)
        } catch {
            self.paymentReferenceWireframe = nil
        }
    }
    func transfer()
    {
        self.transferMoney { (report, error) in
            if let error = error {
                self.showTransactionError(error)
                return
            }
            guard let transferReport = report as? TransferReport else {
                self.showTransactionError(MoneyTranserReportError.failedCreatingReport(reason: "report is nil as "))
                return
            }
            self.showTransactionReport(transferReport)
        }
    }
    // MARK: - Helper Methods
    func transferMoney(completionHandler:@escaping (Report?, Error?) -> Void) {
        //Validate Info
        do {
            let validatedData = try validateTransferData()
            //Construct Transaction Task
            let task = try constructTransactionTask(withSender: validatedData.sender, receiver: validatedData.receiver, amount: validatedData.amount, reference: self.reference)
            //Proceed Transaction with Parameter
            self.runTransaction(withTask: task) { (data, error) in
                if let err = error {
                    completionHandler(nil,err)
                    return
                }
                guard let data = data else {
                    completionHandler(nil,MoneyTransferAPIError.invalidData)
                    return
                }
                //Create Report
                do {
                    let report = try self.generateReport(fromDictionary:data)
                    
                    //completionHandler(report,nil) //Uncomment this line if going to run TestCases
                    //return
                    
                    //Used to display correct data from user input since json hosted online is static data
                    let localReportFromUserInput = self.generateReport(fromSender: validatedData.sender, receiver: validatedData.receiver, amount: validatedData.amount, reference: self.reference)
                    completionHandler(localReportFromUserInput,nil)
                    
                } catch  let error {
                    completionHandler(nil,error)
                }
            }
        } catch let error  {
            completionHandler(nil,error)
        }
    }
    func validateTransferData() throws -> (sender:SendingAccount, receiver:ReceivingAccount, amount:TransferAmount) {
        
        guard let sender = self.sender else { throw MoneyTransferError.noSender }
        guard let receiver = self.receiver else { throw MoneyTransferError.noReceiver }
        guard let amount = self.amount else { throw MoneyTransferError.noAmount }
        
        return (sender:sender, receiver:receiver, amount:amount)
    }
    func constructTransactionTask(withSender sender:SendingAccount, receiver:ReceivingAccount, amount:TransferAmount, reference:PaymentReference?) throws -> MoneyTransferRequest {
        var dict:[String:Any] = [:]
        
        guard let senderString =  ["name":sender.name,"number":sender.number].jsonString else { throw MoneyTransferConversionError.failedSenderStringConversion }
        dict["sender"] = senderString
        guard let receiverString = ["name":receiver.name, "number":receiver.number, "bank":receiver.bank].jsonString else { throw MoneyTransferConversionError.failedReceiverStringConversion }
        dict["receiver"] = receiverString
        guard let amountString = ["value":amount.value, "currecny": amount.currency].jsonString else { throw MoneyTransferConversionError.failedAmountStringConversion }
        dict["amount"] = amountString
        if let notes = reference?.notes {
            dict["notes"] = notes
        }
        if let message = reference?.message {
            dict["message"] = message
        }
        
        return MoneyTransferRequest(data: dict)
    }
    
    func runTransaction(withTask task:MoneyTransferRequest, completionHandler: @escaping ((_ data:[String:Any]?, _ error:Error?) -> Void))
    {
        do {
            dataTask?.cancel()
            //let request = try task.request()
            
            //Dummy request
            let url = URL(string: "https://api.myjson.com/bins/iq9uy")!
            let request = URLRequest(url: url)
            
            dataTask = defaultSession.dataTask(with:request , completionHandler: { (data, resposnse, error) in
                defer { self.dataTask = nil }
                DispatchQueue.main.async(execute: {
                    if let err = error {
                        completionHandler(nil, err)
                        return
                    }
                    guard let data = data else {
                        completionHandler(nil,MoneyTransferAPIError.invalidData)
                        return
                    }
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                        guard let dictInfo = dict as? [String: Any], let result = dictInfo["data"] as? [String:Any] else {
                            completionHandler(nil,MoneyTransferAPIError.invalidData)
                            return
                        }
                        completionHandler(result, nil)
                    } catch let error {
                        completionHandler(nil,error)
                    }
                })
            })
            dataTask?.resume()
        } catch let error {
            completionHandler(nil, error)
        }
    }
    func generateReport(fromDictionary dict:[String:Any]) throws -> Report
    {
        var senderString:String?
        if let sender = dict["sender"] as? [String:Any],
            let senderAccountName = sender["account_name"] as? String,
            let senderAccountNumber = sender["account_number"] as? String {
            senderString = """
            \(senderAccountName)
            \(senderAccountNumber)
            """
        }
        var receiverString:String?
        if let receiver = dict["receiver"] as? [String:Any],
            let receiverBank = receiver["bank_name"] as? String,
            let receiverName = receiver["name"] as? String,
            let receiverAccountNumber = receiver["account_number"] as? String {
            receiverString = """
            \(receiverName)
            \(receiverBank)
            \(receiverAccountNumber)
            """
        }
        var transferAmountString:String?
        if let amount = dict["transfer_amount"] as? [String:Any],
            let value = amount["value"] as? Double,
            let currency = amount["currency"] as? String {
            transferAmountString = "\(value) \(currency)"
        }
        
        var dateString:String?
        if let date = dict["date"] as? String {
            let formattedDate = date.toDate?.toString ?? date
            dateString = formattedDate
        }
        
        var error:String = "Failed Creating Report Reasons:"
        if senderString == nil {
            error += " Invalid Sender"
        }
        if receiverString == nil {
            error += " Invalid Receiver"
        }
        if transferAmountString == nil {
            error += " Invalid Transfer Amount"
        }
        if dateString == nil {
            error += " Invalid Date"
        }
        guard let from = senderString, let to = receiverString, let amount = transferAmountString, let date = dateString else { throw MoneyTranserReportError.failedCreatingReport(reason: error) }
        
        let personalNotes = dict["notes"] as? String
        let message = dict["message"] as? String
        
        return TransferReport(from: from, to: to, transferAmount: amount, date: date, personalNotes: personalNotes, messageToReceiver: message)
    }
}

extension MoneyTransferViewModel {
    func generateReport(fromSender sender:SendingAccount, receiver:ReceivingAccount, amount:TransferAmount, reference:PaymentReference?) -> Report
    {
        let from = """
        \(sender.name)
        \(sender.number)
        """
        let to = """
        \(receiver.name)
        \(receiver.bank)
        \(receiver.number)
        """
        let amount = "\(amount.value) \(amount.currency)"
        let date = Date().toString
        let personalNotes = reference?.notes
        let message = reference?.message
        return TransferReport(from: from, to: to, transferAmount: amount, date: date, personalNotes: personalNotes, messageToReceiver: message)
    }
}
