//
//  MoneyTransferTest.swift
//  MoneyTransferTests
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import XCTest
@testable import MoneyTransfer

class MoneyTransferTest: XCTestCase {

    class MockedMoneyTransferViewModel: MoneyTransferViewModel {
        override func transferMoney(completionHandler: @escaping (Report?, Error?) -> Void) {
            super.transferMoney(completionHandler: completionHandler)
        }
        override func validateTransferData() throws -> (sender: SendingAccount, receiver: ReceivingAccount, amount: TransferAmount) {
            do {
                return try super.validateTransferData()
            } catch let error {
                throw error
            }
        }
        override func constructTransactionTask(withSender sender: SendingAccount, receiver: ReceivingAccount, amount: TransferAmount, reference: PaymentReference?) throws -> MoneyTransferRequest {
            do {
                let _ = try super.constructTransactionTask(withSender: sender, receiver: receiver, amount: amount, reference: reference)
                
                //Fake Request
                let mockedTask = MockedMoneyTransferTask(data: [:])
                
                return mockedTask
            } catch let error {
                throw error
            }
        }
        override func runTransaction(withTask task: MoneyTransferRequest, completionHandler: @escaping (([String : Any]?, Error?) -> Void)) {
            super.runTransaction(withTask: task, completionHandler: completionHandler)
        }
        override func generateReport(fromDictionary dict: [String : Any]) throws -> Report {
            do {
                return try super.generateReport(fromDictionary:dict)
            } catch let error {
                throw error
            }
        }
    }
    
    
    var moneyTrasferModule:MockedMoneyTransferViewModel!
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moneyTrasferModule = MockedMoneyTransferViewModel()
        
        //default complete setup
        let balance = Balance(value: 100_000, currency: "HKD")
        let sender = SendingAccount(name: "Pigy Super Savings", number: "1234567890", balance: balance)
        moneyTrasferModule.sender = sender
        
        let amount = TransferAmount(value: 30_000.0, currency: "HKD")
        moneyTrasferModule.amount = amount
        
        let receiver = ReceivingAccount(name: "Wilfred Derfliw", number: "0987654321", bank: "Pigy Bank")
        moneyTrasferModule.receiver = receiver
        
        let reference = PaymentReference(notes: "Payment for Money Transfer Project", message: "It was nice doing business with you. I'll be giving you a call again if we have a new project. Thanks!")
        moneyTrasferModule.reference = reference
        
      
    }
    
    override func tearDown() {
        moneyTrasferModule = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfulMoneyTransfer() {
        //Given
        //Using default setup
        //Setup the json hosted in the link
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource:"MoneyTransferDummyReport", ofType:"json")
        let url = URL(fileURLWithPath: path!)
        let jsonData = try? Data(contentsOf: url)
        let json = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments)
        let data = json as! [String:Any]
        let dict = data["data"] as? [String:Any]
        let report = try? moneyTrasferModule.generateReport(fromDictionary: dict!)
        let expectedReport:TransferReport = report as! TransferReport
        
        //When
        var transferReport:TransferReport?
        var transferError:Error?
        let promise = expectation(description: "Money transfer transaction completed.")
        
        moneyTrasferModule.transferMoney { (report, error) in
            transferReport = report as? TransferReport
            transferError = error
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        XCTAssertNil(transferError)
        XCTAssertNotNil(transferReport)
        XCTAssertEqual(transferReport, expectedReport)
    }
    
    func testMissingSender()
    {
        //Given
        moneyTrasferModule.sender = nil
        
        //When
        var transferReport:TransferReport?
        var transferError:MoneyTransferError?
        let promise = expectation(description: "Money transfer error missing sender.")
        
        moneyTrasferModule.transferMoney { (report, error) in
            transferReport = report as? TransferReport
            transferError = error as? MoneyTransferError
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        XCTAssertNil(transferReport)
        XCTAssertNotNil(transferError)
        XCTAssertEqual(transferError, MoneyTransferError.noSender)
    }
    
    func testMissingAmount()
    {
        //Given
        moneyTrasferModule.amount = nil
        
        //When
        var transferReport:TransferReport?
        var transferError:MoneyTransferError?
        let promise = expectation(description: "Money transfer error no amount.")
        
        moneyTrasferModule.transferMoney { (report, error) in
            transferReport = report as? TransferReport
            transferError = error as? MoneyTransferError
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        XCTAssertNil(transferReport)
        XCTAssertNotNil(transferError)
        XCTAssertEqual(transferError, MoneyTransferError.noAmount)
    }
    
    func testMissingReceiver()
    {
        //Given
        moneyTrasferModule.receiver = nil
        
        //When
        var transferReport:TransferReport?
        var transferError:MoneyTransferError?
        let promise = expectation(description: "Money transfer error missing rceiver.")
        
        moneyTrasferModule.transferMoney { (report, error) in
            transferReport = report as? TransferReport
            transferError = error as? MoneyTransferError
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        XCTAssertNil(transferReport)
        XCTAssertNotNil(transferError)
        XCTAssertEqual(transferError, MoneyTransferError.noReceiver)
    }
}
