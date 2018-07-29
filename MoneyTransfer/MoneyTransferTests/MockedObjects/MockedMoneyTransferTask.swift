//
//  MockedMoneyTransferTask.swift
//  MoneyTransferTests
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
@testable import MoneyTransfer

class MockedMoneyTransferTask: MoneyTransferRequest {
    
    override func request() throws -> URLRequest
    {
        self.endpoint =  URL(string: "https://api.myjson.com/bins/iq9uy")!
        return URLRequest(url: self.endpoint!)
    }
}
